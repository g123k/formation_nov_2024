import 'package:flutter/cupertino.dart';
import 'package:untitled1/api/open_food_facts_api.dart';
import 'package:untitled1/model/product.dart';

class ProductViewModel extends ValueNotifier<ProductState> {
  ProductViewModel(String barcode) : super(const ProductStateLoading()) {
    loadProduct(barcode);
  }

  Future<void> loadProduct(String barcode) async {
    value = const ProductStateLoading();

    try {
      final apiProduct = await OpenFoodFactsAPIManager().loadProduct(barcode);
      print(apiProduct);

      /// TODO Mapper avec l'API
      value = ProductStateSuccess(generateFakeProduct());
    } catch (e) {
      print(e);
      value = ProductStateError(e);
    }
  }
}

sealed class ProductState {
  const ProductState();
}

class ProductStateLoading extends ProductState {
  const ProductStateLoading();
}

class ProductStateSuccess extends ProductState {
  final Product product;

  const ProductStateSuccess(this.product);
}

class ProductStateError extends ProductState {
  final dynamic error;

  const ProductStateError(this.error);
}
