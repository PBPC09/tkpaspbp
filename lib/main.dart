import 'package:flutter/material.dart';
import 'package:lembarpena/Authentication/login_page.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:litera_land_mobile/BrowseBooks/screens/browse_books_page.dart';
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
                title: 'LembarPena',
                theme: ThemeData(
                    primarySwatch: Colors.deepPurple,
                ),
                home: const LoginPage(),
                routes: {
                    "/home": (BuildContext context) => const LoginPage(),
                },
            ),
        );
    }
}
