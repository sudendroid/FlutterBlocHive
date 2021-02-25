part of 'product_cubit.dart';

@immutable
abstract class ProductState {
  const ProductState();

}

class ProductInitial extends ProductState {
    const ProductInitial();
}

class ProductLoading extends ProductState {
    const ProductLoading();
}

class ProductLoaded extends ProductState {
    final List<Product> products;
    final bool isCartEmpty;
    const ProductLoaded(this.products, this.isCartEmpty);
}