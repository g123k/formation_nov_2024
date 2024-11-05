import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/model/product.dart';

/// Evenements
abstract class ProductEvent {}

class LoadProductEvent extends ProductEvent {
  final String barcode;

  LoadProductEvent(this.barcode);
}

/// BLoC
class ProductBloc extends Bloc<ProductEvent, ProductBlocState> {
  /// Etat initial
  ProductBloc(String barcode) : super(const ProductBlocStateLoading()) {
    /// Quand je reçois l'événement de type LoadProductEvent,
    /// rediriger vers _loadProduct
    on<LoadProductEvent>(_loadProduct);

    /// Charger le produit dès que l'écran est visible
    add(LoadProductEvent(barcode));
  }

  Future<void> _loadProduct(
    LoadProductEvent event,
    Emitter<ProductBlocState> emitter,
  ) async {
    emitter(const ProductBlocStateLoading());

    try {
      // TODO Faire la requête
      await Future.delayed(const Duration(seconds: 2));
      Product product = generateFakeProduct();

      emitter(ProductBlocStateSuccess(product));
    } catch (e) {
      emitter(ProductBlocStateError(e));
    }
  }
}

/// Etat (State)
sealed class ProductBlocState {
  const ProductBlocState();
}

class ProductBlocStateLoading extends ProductBlocState {
  const ProductBlocStateLoading();
}

class ProductBlocStateSuccess extends ProductBlocState {
  final Product product;

  const ProductBlocStateSuccess(this.product);
}

class ProductBlocStateError extends ProductBlocState {
  final dynamic error;

  const ProductBlocStateError(this.error);
}
