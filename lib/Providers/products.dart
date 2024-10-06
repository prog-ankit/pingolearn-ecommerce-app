import 'package:flutter/foundation.dart';
import 'package:pingolearn_ecommerce_app/FirebaseServices/remote_config.dart';
import 'package:pingolearn_ecommerce_app/Models/product.dart';

class ProductsProvider with ChangeNotifier {
  final RemoteConfig remoteConfig;
  List<Product> _products = [];
  ProductsProvider(this.remoteConfig);
  List<Product> get products => _products;
  void setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  bool get showDiscountedPrices => remoteConfig.showDiscountedPrices;
}
