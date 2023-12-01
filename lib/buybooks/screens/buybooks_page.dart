import 'package:flutter/material.dart';
import 'package:lembarpena/widgets/left_drawer.dart';
import 'package:lembarpena/buybooks/screens/cart_page.dart';

class BuyBooksPage extends StatelessWidget {
  BuyBooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buy Books',
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              // const Padding(
              //   padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              //   // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
              //   child: Text(
              //     'Menu', // Text yang menandakan toko
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 30,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              Padding(
              padding: EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartPage(),
                    )
                  );
                },
                child: Text('Cek Keranjang Saya'),
              )
              ),
              // Grid layout
              // GridView.count(
              //   // Container pada card kita.
              //   primary: true,
              //   padding: const EdgeInsets.all(20),
              //   crossAxisSpacing: 10,
              //   mainAxisSpacing: 10,
              //   crossAxisCount: 3,
              //   shrinkWrap: true,
              //   children: items.map((ShopItem item) {
              //     // Iterasi untuk setiap item
              //     return ShopCard(item);
              //   }).toList(),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
