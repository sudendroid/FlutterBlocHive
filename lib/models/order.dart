
import 'package:hive/hive.dart';
import 'package:psi/models/product.dart';

part 'order.g.dart';

@HiveType(typeId:3)
class Order{

  @HiveField(0)
  List<Product> items;

  double get total{
    double t = 0;
    items.forEach((p) { 
        t = t + p.qty*p.price;
    });
    return t;
  }

  Order(this.items);

}