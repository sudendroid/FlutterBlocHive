
import 'package:hive/hive.dart';
import 'package:psi/models/measurement_units.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  String productName;
  @HiveField(1)
  double price;
  @HiveField(2)
  String imageUrl;
  @HiveField(3)
  MeasurementUnit unit;
  @HiveField(4)
  int qty = 0;

  String get unitName {
    return measurementUnits[unit];
  }

  Product(this.productName, this.price, this.unit, {this.imageUrl});
}