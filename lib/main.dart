import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:psi/cubit/product_cubit.dart';
import 'package:psi/data/product_repo.dart';
import 'package:psi/screens/add_product.dart';
import 'package:psi/screens/product_list.dart';
import 'package:psi/screens/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductCubit>(
          create: (BuildContext context) => ProductCubit(ProductRepository()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.pink,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: SplashScreen.ROUTE,
        routes: {
          SplashScreen.ROUTE: (context) => SplashScreen(),
          ProductList.ROUTE: (context) => ProductList(),
          AddProduct.ROUTE: (context) => AddProduct(),
        },
      ),
    );
  }
}
