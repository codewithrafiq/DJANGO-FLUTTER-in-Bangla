from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from todoapp.views import TodoView

route = DefaultRouter()
route.register("todo", TodoView, basename="todos")

urlpatterns = [
    path('admin/', admin.site.urls),
    path("api/", include(route.urls))
]
