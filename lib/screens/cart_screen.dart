import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psi/cubit/cart_cubit.dart';
import 'package:psi/models/product.dart';

class CartScreen extends StatefulWidget {
  static const ROUTE = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    fetchCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: _getPageView(),
    );
  }

  Widget _getPageView() {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is OrderPlaced) {
          showThankOnOrderPlaced();
        }
      },
      builder: (context, state) {
        if (state is CartLoaded) {
          return _buildLoadedView(state.products, state.billingAmount);
        } else if (state is CartLoading) {
          return _buildLoadingView();
        } else if (state is CartEmpty) {
          return _buildEmptyCartView();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildEmptyCartView() {
    return Center(
      child: Text("Cart is empty!"),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoadedView(List<Product> products, double billingAmount) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildCartItem(products[index]);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        ),
        _buildFinalAmountView(billingAmount),
        _buildPlaceOrderView(),
      ],
    );
  }

  Widget _buildFinalAmountView(double billingAmount){
    return Container(
      width: double.infinity,
      height: 30,
      color: Colors.green,
      child:Center(child: Text("Final amount => ₹$billingAmount", style:TextStyle(color: Colors.white))),
    );
  }

  Widget _buildCartItem(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleAvatar(child: Image.network(product.imageUrl)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.productName),
            Text('₹ ${product.price}/${product.unitName}'),
          ],
        ),
        _buildAddToCardView(product),
      ],
    );

  }

  Widget _buildPlaceOrderView() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text("Place Order"),
        onPressed: () {
          saveOrder();
        },
      ),
    );
  }

  Widget _buildAddToCardView(Product p) {
    print('qty of ${p.productName} => ${p.qty}');
    if (p.qty > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    removeFromCart(p);
                  },
                  child: Text("-"),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.pink,
                    onSurface: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${p.qty}'),
                ),
                TextButton(
                  onPressed: () {
                    addToCart(p);
                  },
                  child: Text("+"),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.pink,
                    onSurface: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text('subtotal=> ₹${p.price * p.qty}'),
        ],
      );
    } else {
      return ElevatedButton(
        onPressed: () {
          addToCart(p);
        },
        child: Text("Add to cart"),
      );
    }
  }

  void showThankOnOrderPlaced() {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text("Thank you for placing order"),
    // ));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("Thank you for placing order!"),
            actions: [
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void fetchCartItems() {
    BlocProvider.of<CartCubit>(context).getCartProducts();
  }

  void saveOrder() {
    BlocProvider.of<CartCubit>(context).saveOrder();
  }

  void addToCart(Product product) {
    product.qty = product.qty + 1;
    BlocProvider.of<CartCubit>(context).updateQuantity(product);
  }

  void removeFromCart(Product product) {
    product.qty = product.qty - 1;
    BlocProvider.of<CartCubit>(context).updateQuantity(product);
  }
}
