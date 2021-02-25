import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psi/cubit/product_cubit.dart';
import 'package:psi/models/product.dart';
import 'package:psi/screens/add_product.dart';

class ProductList extends StatefulWidget {
  static const ROUTE = '/productList';

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    fetchProducts(null);
    super.initState();
  }

  void fetchProducts(dynamic data) {
    BlocProvider.of<ProductCubit>(context).getProducts();
  }

  void addToCart(Product product) {
    product.qty = product.qty + 1;
    BlocProvider.of<ProductCubit>(context).updateQuantity(product);
  }

  void removeFromCart(Product product) {
    product.qty = product.qty - 1;
    BlocProvider.of<ProductCubit>(context).updateQuantity(product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
            ),
            ListTile(
              title: Text('Add Product'),
              onTap: () {
                Navigator.popAndPushNamed(context, AddProduct.ROUTE);
              },
            ),
            ListTile(
              title: Text('Delete All Products'),
              onTap: () {
                BlocProvider.of<ProductCubit>(context).removeAllProducts();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Close'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _getPageView(),
    );
  }

  Widget _getPageView() {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial) {
          return _buildInitialView();
        } else if (state is ProductLoading) {
          return _buildLoadingView();
        } else if (state is ProductLoaded) {
          return _buildLoadedView(state.products, state.isCartEmpty);
        } else {
          return _buildInitialView();
        }
      },
    );
  }

  Widget _buildInitialView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No products added yet!',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.ROUTE);
            },
            icon: Icon(Icons.add),
            label: const Text(
              'Add Product',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
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

  Widget _buildCheckoutView(bool isCartEmpty) {
    if (isCartEmpty) {
      return Container();
    }
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        child: Text("Checkout"),
        onPressed: () {},
      ),
    );
  }

  Widget _buildLoadedView(List<Product> products, bool isCartEmpty) {
    
    if (products.length > 0) {
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
          _buildCheckoutView(isCartEmpty),
        ],
      );
    } else {
      return _buildInitialView();
    }
  }
}
