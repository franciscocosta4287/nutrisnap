from rest_framework import serializers
from .models import FoodAnalysis

class FoodAnalysisSerializer(serializers.ModelSerializer):
    class Meta:
        model = FoodAnalysis
        fields = "__all__"

class FoodUploadSerializer(serializers.Serializer):
    image = serializers.ImageField()

# class FoodAnalysisSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = FoodAnalysis
#         fields = ['id', 'image', 'calories', 'protein', 'carbs', 'fats', 'created_at']