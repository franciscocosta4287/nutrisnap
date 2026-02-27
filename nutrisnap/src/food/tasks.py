from celery import shared_task
from django.db import transaction
from .models import FoodAnalysis
from .services import process_image


@shared_task(bind=True, autoretry_for=(Exception,), retry_kwargs={"max_retries": 3, "countdown": 5})
def process_food_analysis(self, analysis_id):
    analysis = None

    try:
        analysis = FoodAnalysis.objects.get(id=analysis_id)

        # Marca como processing
        analysis.status = "processing"
        analysis.save(update_fields=["status"])

        # 🔥 Abrir imagem corretamente
        with analysis.image.open("rb") as img:
            result = process_image(img)

        # 🔥 Validação defensiva
        if not isinstance(result, dict):
            raise ValueError("process_image must return a dict")

        # 🔥 Atualização atômica
        with transaction.atomic():
            analysis.calories = result.get("calories")
            analysis.protein = result.get("protein")
            analysis.carbs = result.get("carbs")
            analysis.fats = result.get("fats")
            analysis.status = "completed"
            analysis.save()

        print(f"✅ Analysis {analysis_id} completed")

    except Exception as e:
        print(f"🔥 ERROR processing analysis {analysis_id}: {str(e)}")

        if analysis:
            analysis.status = "error"
            analysis.save(update_fields=["status"])

        raise e