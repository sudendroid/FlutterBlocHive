part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class LoadingOrders extends OrdersState {}

class NoOrders extends OrdersState {}

class OrdersLoaded extends OrdersState {
  
  final List<Order> orders;

  OrdersLoaded(this.orders);
}
