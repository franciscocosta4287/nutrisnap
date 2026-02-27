from django.urls import path
# from .views import FoodAnalysisView
from .views import FoodAnalysisView, FoodAnalysisDetailView
from . import views
from .views_dashboard import dashboard_metrics, dashboard_chart


urlpatterns = [
    path("analyze/", FoodAnalysisView.as_view()),
    path("analyze/<int:pk>/", FoodAnalysisDetailView.as_view()),
    path("dashboard/metrics/", dashboard_metrics),
    path("dashboard/chart/", dashboard_chart),

]