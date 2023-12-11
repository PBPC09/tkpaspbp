import 'package:flutter/material.dart';
import 'package:lembarpena/BookForum/screens/forum_page.dart';
import 'package:lembarpena/Main/screens/landing_page.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/Authentication/login_page.dart';
import 'package:lembarpena/Wishlist/screens/explore_book.dart';
import 'package:lembarpena/AdminRegisterBook/screens/admin_menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class MenuCard extends StatelessWidget {
  final MenuItem page;

  const MenuCard(this.page, {super.key});

  get request => null; // Constructor

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Material(
      color: page.color,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () async {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${page.name}!")));
          if (page.name == "Home") {
            // TODO: Implement home button functionality.
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ));
          } else if (page.name == "Explore Book") {
            // TODO: Implement explore book button functionality.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExploreBooksPage(),
              ),
            );
          } else if (page.name == "Wishlist") {
            // TODO: Implement wishlist button functionality.
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const WishlistPage(),
            //   ));
          } else if (page.name == "Cart") {
            // TODO: Implement cart button functionality.
          } else if (page.name == "Buy Books") {
            // TODO: Implement buy books button functionality.
          } else if (page.name == "Book Forum") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ForumPage()));
            // TODO: Implement forum button functionality.
          } else if (page.name == "My Order") {
            // TODO: Implement my order button functionality.
          } else if (page.name == "Admin Page") {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminPage()));
          } else if (page.name == "Logout") {
            final response =
                // await request.login("http://10.0.2.2:8000/auth/login/", {
                await request.logout("http://localhost:8000/auth/logout/");
            if (request.loggedIn == false) {
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LandingPage()),
                (Route<dynamic> route) => false,
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Terdapat kesalahan, silakan coba lagi."),
                ),
              );
            }
          }
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  page.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  page.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
