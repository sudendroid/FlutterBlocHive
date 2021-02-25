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
          return _buildLoadedView(state.products);
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

  Widget _buildLoadedView(List<Product> products) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                    child: Image.network(products[index].imageUrl)),
                title: Text(products[index].productName),
                subtitle: Text(
                    '₹ ${products[index].price}/${products[index].unitName}'),
                trailing: _buildAddToCardView(products[index]),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          ),
        ),
        _buildPlaceOrderView(),
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
      return Container(
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
