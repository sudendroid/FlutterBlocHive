import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:psi/data/orders_repo.dart';
import 'package:psi/models/order.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrderRepository orderRepository;

  OrdersCubit(this.orderRepository) : super(OrdersInitial());

  void getOrders() async {
    emit(LoadingOrders());
    List<Order> orders = await orderRepository.getOrders();
    if (orders.isEmpty) {
      emit(NoOrders());
    } else {
      emit(OrdersLoaded(orders));
    }
  }
}
