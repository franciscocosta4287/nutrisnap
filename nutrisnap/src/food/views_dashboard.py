from django.db.models import Count
from django.utils.timezone import now
from django.http import JsonResponse
from datetime import timedelta
from .models import FoodAnalysis


def dashboard_metrics(request):
    total = FoodAnalysis.objects.count()
    completed = FoodAnalysis.objects.filter(status="completed").count()
    processing = FoodAnalysis.objects.filter(status="processing").count()
    error = FoodAnalysis.objects.filter(status="error").count()

    return JsonResponse({
        "total": total,
        "completed": completed,
        "processing": processing,
        "error": error,
    })


def dashboard_chart(request):
    last_7_days = now() - timedelta(days=7)

    data = (
        FoodAnalysis.objects
        .filter(created_at__gte=last_7_days)
        .extra(select={'day': "date(created_at)"})
        .values('day')
        .annotate(count=Count('id'))
        .order_by('day')
    )

    return JsonResponse(list(data), safe=False)

    