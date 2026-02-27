"""
URL configuration for nutrisnap project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.http import JsonResponse
from django.urls import path, include
from django.http import HttpResponse

from django.views.generic import TemplateView

def health(request):
    return JsonResponse({"status": "ok"})


from django.conf import settings
from django.conf.urls.static import static


def home(request):
    return HttpResponse("""
        <h1>Nutrisnap API</h1>
        <p>Bem-vindo ao Nutrisnap!</p>
        <ul>
            <li><a href="/admin/">Admin</a></li>
            <li><a href="/api/">API</a></li>
        </ul>
    """)

urlpatterns = [
    path('', home, name='home'),
    path('admin/', admin.site.urls),
    # path('', health),  # rota raiz
    path('api/', include('food.urls')),
    path("dashboard/", TemplateView.as_view(template_name="dashboard.html")),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)