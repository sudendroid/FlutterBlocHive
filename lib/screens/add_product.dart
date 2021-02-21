import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psi/cubit/product_cubit.dart';
import 'package:psi/models/product.dart';

class AddProduct extends StatefulWidget {
  static const String ROUTE = "/addProduct";

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Product Name',
                ),
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20,),

              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Product Price',
                ),
                controller: priceController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a Snackbar.
                      Product p = Product(nameController.text,
                          double.parse(priceController.text));
                      BlocProvider.of<ProductCubit>(context).addProduct(p);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
