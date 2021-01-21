from rest_framework import generics, mixins, views
from .models import *
from .serializers import *
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from django.contrib.auth.models import User
from rest_framework.response import Response


class ProductView(generics.GenericAPIView, mixins.ListModelMixin):
    queryset = Product.objects.all().order_by('-id')
    serializer_class = ProductSerializers
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        return self.list(request)


class UserView(views.APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        user = request.user
        user_obj = User.objects.get(username=user.username)
        serializer = UserSerializers(user_obj)
        return Response(serializer.data)


class Register(views.APIView):
    def post(self, request):
        serializers = UserSerializers(data=request.data)
        if serializers.is_valid():
            serializers.save()
            return Response({"error": False, "message": "User was Created!"})
        return Response({"error": True, "message": "User Not Created!"})


class CartView(views.APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        user = request.user
        cart_obj = Cart.objects.filter(user=user).filter(isCompile=False)
        data = []
        cart_serializer = CartSerializers(cart_obj, many=True)
        for cart in cart_serializer.data:
            cart_product_obj = CartProduct.objects.filter(cart=cart["id"])
            cart_product_obj_serializer = CartProductSerializers(
                cart_product_obj, many=True)
            cart['cartproducts'] = cart_product_obj_serializer.data
            data.append(cart)
        return Response(data)
