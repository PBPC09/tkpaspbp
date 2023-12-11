import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/Main/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:lembarpena/BuyBooks/models/book.dart';

// class BuyBooksPage extends StatelessWidget {
//   BuyBooksPage({Key? key}) : super(key: key);
//   static const List<String> list = <String>['Semua', 'Rating >= 4', 'Rating < 4'];
//   String dropdownValue = list.first;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Buy Books',
//         ),
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//       ),
//       // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
//       drawer: const LeftDrawer(),
//       body: SingleChildScrollView(
//         // Widget wrapper yang dapat discroll
//         child: Padding(
//           padding: const EdgeInsets.all(10.0), // Set padding dari halaman
//           child: Column(
//             // Widget untuk menampilkan children secara vertikal
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const CartPage(),
//                       )
//                     );
//                   },
//                   child: Text('Cek Keranjang Saya'),
//                 )
//               ),
//               // DROPDOWN
//               // DropdownButton<String>(
//               //   value: dropdownValue,
//               //   icon: const Icon(Icons.arrow_downward),
//               //   elevation: 16,
//               //   underline: Container(
//               //     height: 2,
//               //   ),
//               //   onChanged: (String? value) {
//               //     // This is called when the user selects an item.
//               //     setState(() {
//               //       dropdownValue = value!;
//               //     });
//               //   },
//               //   items: list.map<DropdownMenuItem<String>>((String value) {
//               //     return DropdownMenuItem<String>(
//               //       value: value,
//               //       child: Text(value),
//               //     );
//               //   }).toList(),
//               // );
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class BuyBooksPage extends StatefulWidget {
  const BuyBooksPage({Key? key}) : super(key: key);

  @override
  _BuyBooksPageState createState() => _BuyBooksPageState();
}

class _BuyBooksPageState extends State<BuyBooksPage> {
  Future<List<Book>> fetchProduct() async {
    var url = Uri.parse('http://localhost:8000/buybooks/show_books_json');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Book> listItem = [];
    for (var d in data) {
      if (d != null) {
        listItem.add(Book.fromJson(d));
      }
    }
    return listItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Books'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              // if (snapshot.data == null) {
              //   return const Center(child: CircularProgressIndicator());
              // } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text(
                      "Tidak ada data produk.",
                      style: TextStyle(color: Colors.redAccent, fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => InkWell(
                            // onTap: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => ItemDetailPage(
                            //                 item: snapshot.data![index],
                            //               )));
                            // },
                            child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${snapshot.data![index].fields.title}",
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                  "Author: ${snapshot.data![index].fields.author}"),
                              const SizedBox(height: 10),
                              Text(
                                  "Genres: ${snapshot.data![index].fields.genres}"),
                              const SizedBox(height: 10),
                              Text(
                                  "Rating: ${snapshot.data![index].fields.rating}"),
                            ],
                          ),
                        )));
                // }
              }
            }));
  }
}
