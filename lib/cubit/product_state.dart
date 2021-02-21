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
    const ProductLoaded(this.products);
}