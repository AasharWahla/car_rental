import 'package:carrental/models/User.dart';
import 'package:carrental/providers/currentUser.dart';
import 'package:carrental/screens/Wrapper.dart';
import 'package:carrental/screens/car_edit_screen.dart';
import 'package:carrental/services/auth.dart';
import 'package:carrental/testing.dart';
import 'package:provider/provider.dart';
import './screens/register.dart';
import './screens/singIn.dart';
import './screens/carDisplay_screen.dart';
import './providers/orders.dart';
import './screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './screens/cars_list_screen.dart';
import './screens/orders_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // getting value of user
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: ChangeNotifierProvider(
        create: (_) => CurrentUser(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Car Rental',
//        home: Testing(),
          home: Wrapper(),
          routes: {
//          '/': (ctx) => Testing(),
//          '/': (ctx) => HomeScreen(),
            CarsList.routeName: (ctx) => CarsList(),
            CarDisplay.routeName: (ctx) => CarDisplay(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            EditCar.routeName: (ctx) => EditCar(),
            SingIn.routeName: (ctx) => SingIn(),
            Register.routeName: (ctx) => Register(),
          },
        ),
      ),
    );
  }
}
