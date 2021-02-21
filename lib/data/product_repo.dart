import 'package:psi/models/product.dart';

class ProductRepository {
  List<Product> _pList = [];

  Future<List<Product>> getProducts() async {
    return _pList;
  }

  void addProduct(Product p) {
    _pList.add(p);
  }

  void removeProduct(int id) {
    _pList.removeAt(id);
  }

  void removeAllProducts() {
    _pList.clear();
  }
}
