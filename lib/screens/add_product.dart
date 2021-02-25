import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psi/cubit/product_cubit.dart';
import 'package:psi/models/measurement_units.dart';
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
  MeasurementUnit unit;

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
                    return 'please enter product name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Product Price',
                ),
                controller: priceController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please enter price';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                items: measurementUnits.keys.map((MeasurementUnit value) {
                  return DropdownMenuItem<MeasurementUnit>(
                    value: value,
                    child: Text(measurementUnits[value]),
                  );
                }).toList(),
                hint: Text("Select measure unit"),
                onChanged: (value) {
                  unit = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                validator: (value){
                  if(value==null){
                    return "please select unit";
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          Product p = Product(nameController.text,
                              double.parse(priceController.text), unit);
                          addProductToDB(p);
                          _formKey.currentState.reset();
                        }
                      },
                      child: Text('Add Product'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a Snackbar.
                          Product p = Product(nameController.text,
                              double.parse(priceController.text),unit);
                          addProductToDB(p);
                          _formKey.currentState.reset();
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Add Product And Done'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addProductToDB(Product p){
    p.imageUrl = "https://media.istockphoto.com/photos/orange-picture-id185284489?k=6&m=185284489&s=612x612&w=0&h=x_w4oMnanMTQ5KtSNjSNDdiVaSrlxM4om-3PQTIzFaY=";
    BlocProvider.of<ProductCubit>(context).addProduct(p);
  }

}
