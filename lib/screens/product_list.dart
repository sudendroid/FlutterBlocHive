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

  void fetchProducts(dynamic data){
    BlocProvider.of<ProductCubit>(context).getProducts();
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
                Navigator.popAndPushNamed(context, AddProduct.ROUTE).then(fetchProducts);
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
          return _buildLoadedView(state.products);
        } else {
          return _buildInitialView();
        }
      },
    );
  }

  Widget _buildInitialView() {
    return Center(
      child: RaisedButton(
        onPressed: () {
          Product p = Product('Dummy', 22.0);
          BlocProvider.of<ProductCubit>(context).addProduct(p);
        },
        child: const Text('Add Product', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildLoadedView(List<Product> products) {
    if (products.length > 0) {
      return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].productName),
          );
        },
      );
    }else{
      return _buildInitialView();
    }
  }
}
