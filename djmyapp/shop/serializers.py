from rest_framework import serializers
from .models import Product

from django.contrib.auth import get_user_model


class ProductSerializers(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = "__all__"
        depth = 1


User = get_user_model()


class UserSerializers(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username',
                  'first_name', 'last_name', 'email',)
