import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pingolearn_ecommerce_app/FirebaseServices/remote_config.dart';
import 'package:pingolearn_ecommerce_app/Providers/products.dart';
import 'package:pingolearn_ecommerce_app/Providers/timer.dart';
import 'package:pingolearn_ecommerce_app/Providers/users.dart';
import 'package:pingolearn_ecommerce_app/Screens/home.dart';
import 'package:pingolearn_ecommerce_app/Screens/login.dart';
import 'package:pingolearn_ecommerce_app/Screens/signup.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final remoteConfig = RemoteConfig();
  await remoteConfig.fetchAndActivate();

  runApp(MainApp(remoteConfig: remoteConfig));
}

class MainApp extends StatelessWidget {
  final RemoteConfig remoteConfig;
  const MainApp({super.key, required this.remoteConfig});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider()),
          ChangeNotifierProvider(
              create: (context) => ProductsProvider(remoteConfig)),
          ChangeNotifierProvider(create: (context) => TimerProvider()),
        ],
        child: GetMaterialApp(
          initialRoute: "/login",
          theme: ThemeData(fontFamily: 'Poppins'),
          routes: {
            "/login": (context) => const Login(),
            "/signup": (context) => const Signup(),
            "/home": (context) => const Home(),
          },
          onUnknownRoute: (settings) {
            return GetPageRoute(
              page: () => const Login(),
            );
          },
          debugShowCheckedModeBanner: false,
        ));
  }
}
