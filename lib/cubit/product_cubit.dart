import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:psi/data/product_repo.dart';
import 'package:psi/models/product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductRepository productRepository;

  ProductCubit(this.productRepository) : super(ProductInitial());

  Future<void> getProducts() async{
    emit(ProductLoading());
    List<Product> pList = await productRepository.getProducts();
    emit(ProductLoaded(pList));
  }

  void addProduct(Product p) async{
    productRepository.addProduct(p);
    print(p);
    List<Product> pList = await productRepository.getProducts();
    emit(ProductLoaded(pList));
  }

  void removeProduct(int id) async{
    productRepository.removeProduct(id);
    List<Product> pList = await productRepository.getProducts();
    emit(ProductLoaded(pList));
  }

  void removeAllProducts() async{
    await productRepository.removeAllProducts();
    List<Product> pList = await productRepository.getProducts();
    emit(ProductLoaded(pList));
  }

  void updateQuantity(Product p) async{
    await productRepository.updateProduct(p);
    List<Product> pList = await productRepository.getProducts();
    emit(ProductLoaded(pList));
  }
}
