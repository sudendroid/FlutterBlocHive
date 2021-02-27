import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:psi/cubit/product_cubit.dart';
import 'package:psi/data/order_repo.dart';
import 'package:psi/data/product_repo.dart';
import 'package:psi/models/order.dart';
import 'package:psi/models/product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  ProductRepository productRepository;
  OrderRepository orderRepository;

  CartCubit(this.productRepository, this.orderRepository)
      : super(CartInitial());

  Future<void> getCartProducts() async {
    emit(CartLoading());
    List<Product> pList = await productRepository.getProducts();
    List<Product> cartItems = pList.where((p) => p.qty > 0).toList();

    emit(CartLoaded(cartItems, _getCartBilling(cartItems)));
  }

  double _getCartBilling(List<Product> cartItems) {
    double total = 0;
    cartItems.forEach((element) {
      total = total + (element.price * element.qty);
    });

    return total;
  }

  void updateQuantity(Product p) async {
    await productRepository.updateProduct(p);
    List<Product> pList = await productRepository.getProducts();
    List<Product> cartItems = pList.where((p) => p.qty > 0).toList();
    if (cartItems.length > 0) {
      emit(CartLoaded(cartItems, _getCartBilling(cartItems)));
    } else {
      emit(CartEmpty());
    }
  }

  Future<void> saveOrder() async {
    // save the order
    List<Product> pList = await productRepository.getProducts();
    List<Product> cartItems = pList.where((p) => p.qty > 0).toList();
    await orderRepository.saveOrder(Order(cartItems));
    productRepository.clearCart();
    emit(OrderPlaced());
  }
}
