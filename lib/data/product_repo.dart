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

  Future<List<Product>> getCartItems() async {
    return Hive.box<Product>(productBox).values.where((p) => p.qty > 0);
  }

  Future<void> addProduct(Product p) async {
    // Saves the [value] with an auto-increment key. used for first time adding 
    Hive.box<Product>(productBox).add(p);
  }

  Future<void> updateProduct(Product p) async {
    //save and put is to update an object for certain key
    p.save();
    // Hive.box<Product>(productBox).put(p.key, p);
  }

  void removeProduct(int id) {
  }

  Future<void> removeAllProducts() async {
    await Hive.box<Product>(productBox).clear();
  }

}
