import 'package:flutter/material.dart';
import 'package:lembarpena/BookForum/screens/forum_page.dart';
import 'package:lembarpena/Main/screens/landing_page.dart';
import 'package:lembarpena/Main/screens/menu.dart';
import 'package:lembarpena/Wishlist/screens/explore_book.dart';
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
        borderRadius: BorderRadius.circular(
            10), // Ensure this matches the Card's border radius
        child: InkWell(
          // Area responsive terhadap sentuhan
          onTap: () async {
            // Memunculkan SnackBar ketika diklik
            // ScaffoldMessenger.of(context)
            //   ..hideCurrentSnackBar()
            //   ..showSnackBar(SnackBar(
            //       content: Text("Kamu telah menekan tombol ${page.name}!")));
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
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const WishlistPage(),
              //   ));
            } else if (page.name == "Cart") {
            } else if (page.name == "Buy Books") {
            } else if (page.name == "Book Forum") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ForumPage()));
            } else if (page.name == "My Order") {
            }
            // else if (page.name == "Admin Page") {
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => AdminPage()));
            // }
            else if (page.name == "Logout") {
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
                  MaterialPageRoute(builder: (context) => LandingPage()),
                  (Route<dynamic> route) => false,
                );
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("$message"),
                ));
              }

              // final response =
              //     // await request.login("http://10.0.2.2:8000/auth/login/", {
              //     await request.logout("http://localhost:8000/auth/logout/");
              // if(request.loggedIn == false){
              //   // ignore: use_build_context_synchronously
              //   Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (context) => LandingPage()),
              //   (Route<dynamic> route) => false,
              // );
              // }
              // else{
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //       content: Text("Terdapat kesalahan, silakan coba lagi."),
              //     ),
              //   );
              // }
            }
          },
          borderRadius:
              BorderRadius.circular(10), // Match with Material's border radius
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

// class MenuCard extends StatelessWidget {
//   final MenuItem page;

//   const MenuCard(this.page, {super.key});

//   @override

//   Widget build(BuildContext context) {
//     final request = context.watch<CookieRequest>();
//     return Material(
//       color: page.color,
//       child: InkWell(
//         // Area responsive terhadap sentuhan
//         onTap: () async {
//           // Memunculkan SnackBar ketika diklik
//           // ScaffoldMessenger.of(context)
//           //   ..hideCurrentSnackBar()
//           //   ..showSnackBar(SnackBar(
//           //       content: Text("Kamu telah menekan tombol ${page.name}!")));
//           if (page.name == "Home") {

//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => MyHomePage(),
//                 ));
//           } else if (page.name == "Explore Book") {

//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const ExploreBooksPage(),
//               ),
//             );
//           } else if (page.name == "Wishlist") {

//             // Navigator.pushReplacement(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (context) => const WishlistPage(),
//             //   ));
//           } else if (page.name == "Cart") {

//           } else if (page.name == "Buy Books") {

//           } else if (page.name == "Book Forum") {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const ForumPage()));

//           } else if (page.name == "My Order") {

//           }
//           // else if (page.name == "Admin Page") {
//           //   Navigator.push(
//           //       context, MaterialPageRoute(builder: (context) => AdminPage()));
//           // }
//           else if (page.name == "Logout") {
//               final response = await request.logout("http://localhost:8000/auth/logout/");
//               // await request.login("http://10.0.2.2:8000/auth/login/", {
//               String message = response["message"];
//               if (response['status']) {
//                 String uname = response["username"];
//                 // ignore: use_build_context_synchronously
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   content: Text("$message Sampai jumpa, $uname."),
//                 ));
//                 // ignore: use_build_context_synchronously
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => LandingPage()),
//                   (Route<dynamic> route) => false,
//                 );
//               } else {
//                 // ignore: use_build_context_synchronously
//                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                   content: Text("$message"),
//                 ));
//               }

//               // final response =
//               //     // await request.login("http://10.0.2.2:8000/auth/login/", {
//               //     await request.logout("http://localhost:8000/auth/logout/");
//               // if(request.loggedIn == false){
//               //   // ignore: use_build_context_synchronously
//               //   Navigator.of(context).pushAndRemoveUntil(
//               //   MaterialPageRoute(builder: (context) => LandingPage()),
//               //   (Route<dynamic> route) => false,
//               // );
//               // }
//               // else{
//               //   ScaffoldMessenger.of(context).showSnackBar(
//               //     const SnackBar(
//               //       content: Text("Terdapat kesalahan, silakan coba lagi."),
//               //     ),
//               //   );
//               // }
//           }
//         },
//         child: Container(
//           // Container untuk menyimpan Icon dan Text
//           padding: const EdgeInsets.all(8),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   page.icon,
//                   color: Colors.white,
//                   size: 30.0,
//                 ),
//                 const Padding(padding: EdgeInsets.all(3)),
//                 Text(
//                   page.name,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
