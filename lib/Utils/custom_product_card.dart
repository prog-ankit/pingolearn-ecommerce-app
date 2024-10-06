import 'package:flutter/material.dart';
import 'package:pingolearn_ecommerce_app/Models/product.dart';
import 'package:pingolearn_ecommerce_app/Utils/constants.dart';

class CustomProductCard extends StatelessWidget {
  final Product product;
  final bool showDiscountedPrices;
  const CustomProductCard(
      {super.key, required this.product, required this.showDiscountedPrices});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Image.network(
                  product.thumbnail,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                child: Text(
                  product.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                child: Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              if (showDiscountedPrices)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "\$${product.originalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Utilities.GRAY_SHADE_2,
                            fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "\$${product.discountedPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 12),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "${product.discountPercentage.toStringAsFixed(2)}%",
                        style:
                            const TextStyle(color: Colors.green, fontSize: 12),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  "\$${product.originalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
