import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingolearn_ecommerce_app/FirebaseServices/auth_service.dart';
import 'package:pingolearn_ecommerce_app/Utils/constants.dart';
import 'package:pingolearn_ecommerce_app/Utils/custom_app_bar.dart';
import 'package:pingolearn_ecommerce_app/Utils/custom_textform_field.dart';

import '../Utils/custom_button_validate.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Utilities.GRAY_SHADE_1,
      appBar: const CustomAppBar(
        appBarBgColor: Utilities.GRAY_SHADE_1,
        titleColor: Utilities.DARK_BLUE,
         appConstColors: Colors.black,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    CustomTextFormField(
                      controller: nameController,
                      hintText: "Name",
                      keyboardType: TextInputType.text,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Name field is empty. ';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'Empty Email Not Allowed.';
                          }
                          RegExp regex = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (!regex.hasMatch(value)) {
                            return 'Email is invalid.';
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: 'Password',
                      obscureText: true,
                      validation: (value) {
                        if (value!.isEmpty) {
                          return 'Empty Password Not Allowed!';
                        }
                        if (value.length < 8) {
                          return "Password length should be greater than 8";
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    CustomValidate(
                      btnText: "Signup",
                      routeText: "Already have an account?",
                      routeOption: "Login",
                      onButtonPressed: () async {
                        if (_key.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          Map<bool, String> responseMap =
                              await AuthServices.registerUser(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text);
                          setState(() {
                            isLoading = false;
                          });
                          if (responseMap.keys.first) {
                            Get.snackbar('Registration Successfull!!',
                                'You are redirected to Home Screen.',
                                backgroundColor: Colors.green.shade300,
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white);
                                Get.offAllNamed('/login');
                          } else {
                            Get.snackbar(
                                'Registration Failed!!', responseMap[false].toString(),
                                backgroundColor: Colors.red.shade500,
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white);
                          }
                        }
                      },
                      onNavigatePressed: () => Get.offNamed("/login"),
                    )
                  ],
                ),
              )),
    );
  }
}
