import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:psi/cubit/product_cubit.dart';
import 'package:psi/data/product_repo.dart';
import 'package:psi/models/measurement_units.dart';
import 'package:psi/models/product.dart';
import 'package:psi/screens/add_product.dart';
import 'package:psi/screens/product_list.dart';
import 'package:psi/screens/splash.dart';

void main() async{
  // Directory appDocDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(MeasurementUnitAdapter());
  await Hive.openBox<Product>(ProductRepository.productBox);
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
