from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import FoodAnalysis
from .serializers import FoodUploadSerializer, FoodAnalysisSerializer
from .tasks import process_food_analysis


class FoodAnalysisView(APIView):
    

    def get(self, request):
        analyses = FoodAnalysis.objects.all().order_by("-created_at")
        serializer = FoodAnalysisSerializer(analyses, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = FoodUploadSerializer(data=request.data)

        if not serializer.is_valid():
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        image = serializer.validated_data["image"]

        # cria análise sem processar ainda
        analysis = FoodAnalysis.objects.create(
            image=image,
            status="processing"
        )

        # dispara processamento em background
        process_food_analysis.delay(analysis.id)

        return Response(
            {
                "id": analysis.id,
                "status": analysis.status,
                "message": "Image received. Processing in background."
            },
            status=status.HTTP_202_ACCEPTED
        )
    
class FoodAnalysisDetailView(APIView):

    def get(self, request, pk):
        try:
            analysis = FoodAnalysis.objects.get(pk=pk)
        except FoodAnalysis.DoesNotExist:
            return Response({"error": "Not found"}, status=404)

        serializer = FoodAnalysisSerializer(analysis)
        return Response(serializer.data)