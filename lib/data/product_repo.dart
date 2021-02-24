import 'package:hive/hive.dart';
import 'package:psi/models/product.dart';

class ProductRepository {
  static const productBox = 'productBox';
  
  ProductRepository() {
    // await Hive.openBox<Product>(productBox);
  }

  Future<List<Product>> getProducts() async {    
    return Hive.box<Product>(productBox).values.toList();
  }

  Future<void> addProduct(Product p) async {
    // p.save();
    Hive.box<Product>(productBox).add(p);
  }

  void removeProduct(int id) {
  }

  Future<void> removeAllProducts() async {
    await Hive.box<Product>(productBox).clear();
  }
}
