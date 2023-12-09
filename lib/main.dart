import 'package:flutter/material.dart';
import 'package:lembarpena/authentication/login_page.dart';
<<<<<<< HEAD
// import 'package:google_fonts/google_fonts.dart';
// import 'package:litera_land_mobile/BrowseBooks/screens/browse_books_page.dart';
import 'package:lembarpena/AdminRegisterBook/screens/admin_menu.dart';
=======
>>>>>>> 09b7086de19b1fc76b799359cd8bfb045191bfc4
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
                home: LoginPage(),
                routes: {
                    "/home": (BuildContext context) => const LoginPage(),
                },
            ),
        );
    }
}
