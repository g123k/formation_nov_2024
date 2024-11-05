import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:untitled1/api/model/product_response.dart';

part 'open_food_facts_api.g.dart';

@RestApi()
abstract class OpenFoodFactsAPI {
  factory OpenFoodFactsAPI(Dio dio, {required String baseUrl}) =
      _OpenFoodFactsAPI;

  // getProduct?barcode=5000159484695
  @GET('/getProduct')
  Future<ProductAPIEntity> loadProduct(@Query('barcode') String barcode);
}

class OpenFoodFactsAPIManager {
  factory OpenFoodFactsAPIManager() {
    _instance ??= OpenFoodFactsAPIManager._();
    return _instance!;
  }

  static OpenFoodFactsAPIManager? _instance;

  final OpenFoodFactsAPI _api;

  OpenFoodFactsAPIManager._()
      : _api = OpenFoodFactsAPI(Dio(),
            baseUrl: 'https://api.formation-android.fr/v2/');

  Future<ProductAPIEntity> loadProduct(String barcode) =>
      _api.loadProduct(barcode);
}
