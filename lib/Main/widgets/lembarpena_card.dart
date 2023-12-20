import 'package:flutter/material.dart';
import 'package:lembarpena/bookforum/screens/forum_page.dart';
import 'package:lembarpena/Main/screens/landing_page.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/checkoutbook/screens/my_order.dart';
// import 'package:lembarpena/checkoutbook/screens/checkoutpage.dart';
import 'package:lembarpena/wishlist/screens/explore_book.dart';
import 'package:lembarpena/buybooks/screens/buybooks_page.dart';
import 'package:lembarpena/buybooks/screens/cart_page.dart';
import 'package:lembarpena/wishlist/screens/my_wishlist.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


class MenuCard extends StatelessWidget {
  final MenuItem page;

  const MenuCard(this.page, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded edges
      ),
      elevation: 5, // Drop shadow
      child: Material(
        color: page.color,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          // Area responsive terhadap sentuhan
          onTap: () async {
            if (page.name == "Home") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            } else if (page.name == "Explore Book") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExploreBooksPage(),
                ),
              );
            } else if (page.name == "Wishlist") {
<<<<<<< HEAD
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WishlistPage(
                      wishlist: [],
                    ),
                  ));
=======
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WishlistPage(),
                ));
>>>>>>> 273332b4a49442091214b79e7554aba2cebfbeac
            } else if (page.name == "Cart") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartPage()));
            } else if (page.name == "Buy Books") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BuyBooksPage()));
            } else if (page.name == "Book Forum") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ForumPage()));
            } else if (page.name == "My Order") {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyOrderPage()));
            } else if (page.name == "Logout") {
              final response =
                  await request.logout("http://localhost:8000/auth/logout/");
              // await request.login("http://10.0.2.2:8000/auth/login/", {
              String message = response["message"];
              if (response['status']) {
                String uname = response["username"];
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message Sampai jumpa, $uname."),
                ));
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                  (Route<dynamic> route) => false,
                );
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(message),
                ));
              }
            }
          },
          borderRadius: BorderRadius.circular(10),
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
      ),
    );
  }
}

