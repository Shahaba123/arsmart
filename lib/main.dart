import 'package:arsmart/admin/admin%20home.dart';
import 'package:arsmart/admin/admin%20login.dart';
import 'package:arsmart/admin/seller%20manage.dart';
import 'package:arsmart/admin/user%20manage.dart';
import 'package:arsmart/admin/view%20feedback.dart';
import 'package:arsmart/admin/view%20order.dart';
import 'package:arsmart/choose.dart';
import 'package:arsmart/firebase_options.dart';
import 'package:arsmart/seller/product%20screen.dart';
import 'package:arsmart/seller/seller%20forgot.dart';
import 'package:arsmart/seller/seller%20home.dart';
import 'package:arsmart/seller/seller%20login.dart';
import 'package:arsmart/seller/seller%20signup%20screen.dart';
import 'package:arsmart/seller/view%20feedback.dart';
import 'package:arsmart/seller/view%20order.dart';
import 'package:arsmart/user/categories.dart';
import 'package:arsmart/user/edit%20profile.dart';
import 'package:arsmart/user/forgot.dart';
import 'package:arsmart/user/order.dart';
import 'package:arsmart/user/purchase.dart';
import 'package:arsmart/user/user%20login.dart';
//import 'package:arsmart/seller/seller%20signup.dart';
import 'package:arsmart/user/user%20signup%20screen.dart';
import 'package:arsmart/user/userhome.dart';
import 'package:arsmart/user/view%20product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  UserHomePage(),
    );
  }
}
