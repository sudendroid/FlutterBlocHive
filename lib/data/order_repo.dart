import 'package:hive/hive.dart';
import 'package:psi/models/order.dart';

class OrderRepository {
  static const orderBox = 'orderBox';

  Future<void> saveOrder(Order order) async {
    // Saves the [value] with an auto-increment key. used for first time adding
    Hive.box<Order>(orderBox).add(order);
  }
}
