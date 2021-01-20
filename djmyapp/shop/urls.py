from django.urls import path
from .views import *

urlpatterns = [
    path("products/", ProductView.as_view()),
    path('user/', UserView.as_view()),
]
