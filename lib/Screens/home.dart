import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingolearn_ecommerce_app/FirebaseServices/api_services.dart';
import 'package:pingolearn_ecommerce_app/FirebaseServices/auth_service.dart';
import 'package:pingolearn_ecommerce_app/Providers/products.dart';
import 'package:pingolearn_ecommerce_app/Utils/constants.dart';
import 'package:pingolearn_ecommerce_app/Utils/custom_app_bar.dart';
import 'package:pingolearn_ecommerce_app/Utils/custom_product_card.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    Map<bool, String> response = await ApiServices.fetchProducts(context);
    setState(() {
      _isLoading = false;
    });
    if (!response.keys.first) {
      Get.snackbar('Failure', response[false].toString(),
          backgroundColor: Colors.red.shade500,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarBgColor: Utilities.DARK_BLUE,
        titleColor: Colors.white,
        appConstColors: Colors.white,
        isHome: true,
        onLogOutPressed: () async {
          bool status = await AuthServices.signOut(context);
          if (status) {
            Get.offAllNamed('/login');
          } else {
            Get.snackbar('Logout Failed', 'Something might have gone wrong!!',
                backgroundColor: Colors.red.shade500,
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white);
          }
        },
      ),
      body: Consumer<ProductsProvider>(
        builder: (context, productProvider, child) {
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productProvider.products.isEmpty) {
            return const Center(
              child: Text(
                'Currently, there are no products in our Store!!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: productProvider.products.length,
                itemBuilder: (context, index) {
                  final product = productProvider.products[index];
                  return CustomProductCard(
                      product: product,
                      showDiscountedPrices:
                          productProvider.showDiscountedPrices);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
