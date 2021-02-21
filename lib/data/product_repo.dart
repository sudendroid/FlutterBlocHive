import 'package:psi/models/product.dart';

class ProductRepository {
  List<Product> _pList = [
    Product('apple', 22.0),
    Product('mango', 24.0),
  ];

  Future<List<Product>> getProducts() async {
    return _pList;
  }

  void addProduct(Product p) {
    _pList.add(p);
  }

  void removeProduct(int id) {
    _pList.removeAt(id);
  }
}
