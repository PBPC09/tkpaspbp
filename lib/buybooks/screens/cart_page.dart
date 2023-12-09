import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:lembarpena/BuyBooks/models/cart_item.dart';
import 'package:lembarpena/authentication/login_page.dart';
// import 'package:lembarpena/buybooks/widgets/cart_list.dart';


class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<List<CartItem>> fetchProduct() async {
    String uname = LoginPage.uname;
    var url = Uri.parse('http://127.0.0.1:8000/show_cart_json/$uname/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<CartItem> listItem = [];
    for (var d in data) {
      if (d != null) {
        listItem.add(CartItem.fromJson(d));
      }
    }
    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Keranjang Saya'),
        ),
        drawer: const LeftDrawer(),
        // body: FutureBuilder(
        //     future: fetchProduct(),
        //     builder: (context, AsyncSnapshot snapshot) {
        //       if (snapshot.data == null) {
        //         return const Center(child: CircularProgressIndicator());
        //       } else {
        //         if (!snapshot.hasData) {
        //           return const Column(
        //             children: [
        //               Text(
        //                 "Tidak ada data produk.",
        //                 style: TextStyle(color: Colors.redAccent, fontSize: 20),
        //               ),
        //               SizedBox(height: 8),
        //             ],
        //           );
        //         } else {
        //           return ListView.builder(
        //               itemCount: snapshot.data!.length,
        //               itemBuilder: (_, index) => InkWell(
        //                   onTap: () {
        //                     Navigator.push(
        //                         context,
        //                         MaterialPageRoute(
        //                             builder: (context) => ItemDetailPage(
        //                                   item: snapshot.data![index],
        //                                 )));
        //                   },
        //                   child: Container(
        //                     margin: const EdgeInsets.symmetric(
        //                         horizontal: 16, vertical: 12),
        //                     padding: const EdgeInsets.all(20.0),
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.start,
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Text(
        //                           "${snapshot.data![index].fields.name}",
        //                           style: const TextStyle(
        //                             fontSize: 18.0,
        //                             fontWeight: FontWeight.bold,
        //                           ),
        //                         ),
        //                         const SizedBox(height: 10),
        //                         Text("${snapshot.data![index].fields.amount}"),
        //                         const SizedBox(height: 10),
        //                         Text(
        //                             "${snapshot.data![index].fields.description}")
        //                       ],
        //                     ),
        //                   )));
        //         }
        //       }
        //     }
        //     )
        );
  }
}