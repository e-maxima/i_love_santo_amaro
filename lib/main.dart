import 'package:ILoveSantoAmaro/provider/app.dart';
import 'package:ILoveSantoAmaro/provider/product.dart';
import 'package:ILoveSantoAmaro/provider/user.dart';
import 'package:ILoveSantoAmaro/screens/home.dart';
import 'package:ILoveSantoAmaro/screens/login.dart';
import 'package:ILoveSantoAmaro/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ChangeNotifierProvider.value(value: AppProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: ScreensController(),
    ),
  ));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    switch (user.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
        print('Login');
        return Login();
      case Status.Authenticating:
        print('Login');
        return Login();
      case Status.Authenticated:
        print('HomePage');
        return HomePage();
      default:
        print('Default Login');
        return Login();
    }
  }
}
