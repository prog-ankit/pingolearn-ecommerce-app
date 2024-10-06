import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingolearn_ecommerce_app/FirebaseServices/auth_service.dart';
import 'package:pingolearn_ecommerce_app/Providers/users.dart';
import 'package:pingolearn_ecommerce_app/Utils/constants.dart';
import 'package:pingolearn_ecommerce_app/Utils/custom_app_bar.dart';
import 'package:pingolearn_ecommerce_app/Utils/custom_button_validate.dart';
import 'package:pingolearn_ecommerce_app/Utils/custom_textform_field.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUserLoggedInStatus();
    });
  }

  void fetchUserLoggedInStatus() async {
    await Provider.of<UserProvider>(context, listen: false).checkUserLoggedIn();
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      Get.offAllNamed('/home');
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        btnText: "Login",
                        routeText: "New Here?",
                        routeOption: "Signup",
                        onButtonPressed: () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Map<bool, String> responseMap =
                                await AuthServices.login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context);
                            setState(() {
                              isLoading = false;
                            });
                            if (responseMap.keys.first) {
                              Get.snackbar('Login Successfull!!',
                                  'You are redirected to Home Screen.',
                                  backgroundColor: Colors.green.shade300,
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white);
                              Get.offNamed('/home');
                            } else {
                              if (responseMap[false]
                                  .toString()
                                  .contains("invalid-credential")) {
                                Get.snackbar('Login Failed!!',
                                    "Your credentials are incorrect. ",
                                    backgroundColor: Colors.red.shade500,
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white);
                              }

                            }
                          }
                        },
                        onNavigatePressed: () => Get.offNamed('/signup'),
                      )
                    ],
                  ),
                )));
  }
}
