import 'package:flutter/material.dart';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/buybooks/screens/cart_page.dart';
import 'package:lembarpena/buybooks/screens/buybooks_page.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
    Widget build(BuildContext context) {
        return Provider(
            create: (_) {
                CookieRequest request = CookieRequest();
                return request;
            },
            child: MaterialApp(
                title: 'TOKO PBP',
                theme: ThemeData(
                    primarySwatch: Colors.deepPurple,
                ),
                home: BuyBooksPage(),
                routes: {
                    "/home": (BuildContext context) => const CartPage(),
                },
            ),
        );
    }
}