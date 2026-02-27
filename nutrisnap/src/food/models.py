# from django.db import models

# class FoodAnalysis(models.Model):
#     STATUS_CHOICES = [
#     ("processing", "Processing"),
#     ("done", "Done"),
#     ("error", "Error"),
#     ]

#     status = models.CharField(
#         max_length=20,
#         choices=STATUS_CHOICES,
#         default="processing"
#     )
    
    
#     image = models.ImageField(upload_to="foods/")
#     calories = models.FloatField()
#     protein = models.FloatField()
#     carbs = models.FloatField()
#     fats = models.FloatField()
#     created_at = models.DateTimeField(auto_now_add=True)

    

#     def __str__(self):
#         return f"Analysis {self.id} - {self.created_at}"


from django.db import models


class FoodAnalysis(models.Model):

    STATUS_CHOICES = [
        ("processing", "Processing"),
        ("done", "Done"),
        ("error", "Error"),
    ]

    image = models.ImageField(upload_to="foods/")
    calories = models.FloatField(null=True, blank=True)
    protein = models.FloatField(null=True, blank=True)
    carbs = models.FloatField(null=True, blank=True)
    fats = models.FloatField(null=True, blank=True)

    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default="processing"
    )

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Analysis {self.id} - {self.status}"