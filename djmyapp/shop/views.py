from rest_framework import generics, mixins, views
from .models import *
from .serializers import *
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from django.contrib.auth.models import User
from rest_framework.response import Response


# class ProductView(generics.GenericAPIView, mixins.ListModelMixin):
#     queryset = Product.objects.all().order_by('-id')
#     serializer_class = ProductSerializers
#     permission_classes = [IsAuthenticated, ]
#     authentication_classes = [TokenAuthentication, ]

#     def get(self, request):
#         return self.list(request)


class ProductView(views.APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        user = request.user
        query = Product.objects.all()
        serializers = ProductSerializers(query, many=True)
        data = []
        for prod in serializers.data:
            fab_query = Favorit.objects.filter(
                user=user).filter(product_id=prod["id"])
            if fab_query:
                prod['favorit'] = fab_query[0].isFavorit
            else:
                prod['favorit'] = False
            data.append(prod)
        return Response(data)


class FavoritView(views.APIView):
    authentication_classes = [TokenAuthentication, ]
    permission_classes = [IsAuthenticated, ]

    def post(self, request):
        data = request.data["id"]
        user = request.user
        single_product = Favorit.objects.filter(user=user).filter(id=data)
        if single_product:
            fab = single_product[0].isFavorit
            prod = Favorit.objects.get(id=single_product[0].id)
            prod.isFavorit = not fab
            prod.save()
        else:
            Favorit.objects.create(product_id=data, user=user, isFavorit=True)
        return Response({"message": "response is Get Successfully"})


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
        cart_obj = Cart.objects.filter(
            user=user).filter(isCompile=False).first()
        cart_serializer = CartSerializers(cart_obj)
        return Response(cart_serializer.data)


class CartProductView(views.APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def get(self, request):
        user = request.user
        cart_obj = Cart.objects.filter(
            user=user).filter(isCompile=False).first()
        cart_product_obj = CartProduct.objects.filter(cart=cart_obj.id)
        cart_product_obj_serializer = CartProductSerializers(
            cart_product_obj, many=True)
        data = []
        for cproduct in cart_product_obj_serializer.data:
            product_obj = Product.objects.filter(
                id=cproduct['product'][0]).first()
            cart_product_obj_serializer = ProductSerializers(product_obj)
            cproduct['product'] = cart_product_obj_serializer.data
            data.append(cproduct)
        return Response(data)


class AddToCart(views.APIView):
    permission_classes = [IsAuthenticated, ]
    authentication_classes = [TokenAuthentication, ]

    def post(sefl, request):
        product_id = request.data['id']
        product_obj = Product.objects.get(id=product_id)
        print(product_obj, "product_obj")
        cart_cart = Cart.objects.filter(
            user=request.user).filter(isCompile=False).first()
        cart_product_obj = CartProduct.objects.filter(
            product__id=product_id).first()

        try:
            if cart_cart:
                print(cart_cart)
                print("OLD CART")
                this_product_in_cart = cart_cart.cartproduct_set.filter(
                    product=product_obj)
                if this_product_in_cart.exists():
                    # print("OLD CART PRODUCT--OLD CART")
                    cartprod_uct = CartProduct.objects.filter(
                        product=product_obj).filter(cart__isCompile=False).first()
                    cartprod_uct.quantity += 1
                    cartprod_uct.subtotal += product_obj.selling_price
                    cartprod_uct.save()
                    cart_cart.total += product_obj.selling_price
                    cart_cart.save()
                else:
                    print("NEW CART PRODUCT CREATED--OLD CART")
                    cart_product_new = CartProduct.objects.create(
                        cart=cart_cart,
                        price=product_obj.selling_price,
                        quantity=1,
                        subtotal=product_obj.selling_price
                    )
                    cart_product_new.product.add(product_obj)
                    cart_cart.total += product_obj.selling_price
                    cart_cart.save()
            else:
                # print(cart_cart)
                # print("NEW CART CREATED")
                Cart.objects.create(user=request.user,
                                    total=0, isCompile=False)
                new_cart = Cart.objects.filter(
                    user=request.user).filter(isCompile=False).first()
                cart_product_new = CartProduct.objects.create(
                    cart=new_cart,
                    price=product_obj.selling_price,
                    quantity=1,
                    subtotal=product_obj.selling_price
                )
                cart_product_new.product.add(product_obj)
                # print("NEW CART PRODUCT CREATED")
                new_cart.total += product_obj.selling_price
                new_cart.save()

            response_mesage = {
                'error': False, 'message': "Product add to card successfully", "productid": product_id}

        except:
            response_mesage = {'error': True,
                               'message': "Product Not add!Somthing is Wromg"}

        return Response(response_mesage)
