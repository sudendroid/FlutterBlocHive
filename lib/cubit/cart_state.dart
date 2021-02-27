part of 'cart_cubit.dart';

@immutable
abstract class CartState extends ProductState{
  const CartState();
}

class CartInitial extends CartState {}

class CartLoading extends CartState {
  const CartLoading();
}

class CartEmpty extends CartState{
  const CartEmpty();
}

class CartLoaded extends CartState {
  final List<Product> products;
  final double billingAmount;
  const CartLoaded(this.products, this.billingAmount);
}

class OrderPlaced extends CartState{
  const OrderPlaced();
}
