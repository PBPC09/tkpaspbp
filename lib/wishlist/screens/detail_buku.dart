// // detail_buku.dart

// import 'package:flutter/material.dart';
// import 'package:lembarpena/wishlist/models/book.dart'; // Make sure to import the correct model

// class DetailPage extends StatelessWidget {
//   final String itemName;
//   final String price;
//   final String itemDescription;
//   final int itemAmount;

//   DetailPage({
//     required this.itemName,
//     required this.price,
//     required this.itemDescription,
//     required this.itemAmount,
//   });

//   factory DetailPage.fromProduct(Product product) {
//     return DetailPage(
//       itemName: product.fields.title,
//       price: product.fields.price,
//       itemDescription: product.fields.description,
//       itemAmount: product.fields.pageCount,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Custom back button
//             GestureDetector(
//               onTap: () {
//                 // Navigate back to the previous screen
//                 Navigator.pop(context);
//               },
//               child: Row(
//                 children: [
//                   Icon(Icons.arrow_back),
//                   Text(' Back', style: TextStyle(fontSize: 16)),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               '$itemName',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text('Price: $price'),
//             const SizedBox(height: 10),
//             Text('Description: $itemDescription'),
//             const SizedBox(height: 10),
//             Text('Amount: $itemAmount'),
//           ],
//         ),
//       ),
//     );
//   }
// }
