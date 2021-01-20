from rest_framework import generics, mixins
from .models import Product
from .serializers import ProductSerializers


class ProductView(generics.GenericAPIView, mixins.ListModelMixin):
    queryset = Product.objects.all().order_by('-id')
    serializer_class = ProductSerializers

    def get(self, request):
        return self.list(request)
