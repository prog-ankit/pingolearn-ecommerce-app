import 'package:flutter/material.dart';
import 'package:pingolearn_ecommerce_app/Models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pingolearn_ecommerce_app/Providers/products.dart';
import 'package:provider/provider.dart';

class ApiServices {
  static const String baseUri = "https://dummyjson.com/products";
  static Future<Map<bool, String>> fetchProducts(BuildContext context) async {
    Map<bool, String> responseMap = <bool, String>{};
    try {
      final response = await http.get(Uri.parse(baseUri));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Product> products = [];
        for (var productData in jsonData['products']) {
          products.add(Product.fromJson(productData));
        }
        responseMap[true] = "Success";
        Provider.of<ProductsProvider>(context, listen: false)
            .setProducts(products);
      } else {
        responseMap[false] = "Failed to load Products. ";
      }
    } catch (error) {
      responseMap[false] = error.toString();
    }
    return responseMap;
  }
}
