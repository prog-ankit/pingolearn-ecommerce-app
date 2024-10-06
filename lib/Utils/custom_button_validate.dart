import 'package:flutter/material.dart';
import 'package:pingolearn_ecommerce_app/Utils/constants.dart';

class CustomValidate extends StatelessWidget {
  final String btnText;
  final String routeText;
  final String routeOption;
  final VoidCallback onButtonPressed;
  final VoidCallback onNavigatePressed;

  const CustomValidate(
      {super.key,
      required this.btnText,
      required this.routeText,
      required this.routeOption,
      required this.onButtonPressed,
      required this.onNavigatePressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: ElevatedButton(
            onPressed: onButtonPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Utilities.DARK_BLUE,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text(
              btnText,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              routeText,
              style: const TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.w400),
            ),
            TextButton(
              onPressed: onNavigatePressed,
              child: Text(
                routeOption,
                style: const TextStyle(
                    color: Utilities.DARK_BLUE,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 40,
        )
      ],
    );
  }
}
