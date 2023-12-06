import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final String currency;
  final double totalPrice;

  CheckoutPage({
    required this.cartItems,
    required this.currency,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Produk')),
                DataColumn(label: Text('Harga Satuan')),
                DataColumn(label: Text('Jumlah')),
                DataColumn(label: Text('Subtotal Harga')),
              ],
              rows: cartItems.map((product) {
                return DataRow(cells: [
                  DataCell(Text(product['book']['title'])),
                  DataCell(Text(
                      '${product['book']['currency']} ${product['book']['price']}')),
                  DataCell(Text('${product['quantity']}')),
                  DataCell(Text('${product['subtotal']}')),
                ]);
              }).toList(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Total Harga: ${currency} ${totalPrice}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),
            const ListTile(
              title: Text('Metode Pembayaran:'),
              contentPadding: EdgeInsets.all(0.0),
            ),
            RadioListTile(
              title: const Text('Kartu Kredit'),
              value: 'Kartu Kredit',
              groupValue: null,
              onChanged: (value) {
                // Handle radio button changes
              },
            ),
            RadioListTile(
              title: const Text('Kartu Debit'),
              value: 'Kartu Debit',
              groupValue: null,
              onChanged: (value) {
                // Handle radio button changes
              },
            ),
            RadioListTile(
              title: const Text('Transfer Bank'),
              value: 'Transfer Bank',
              groupValue: null,
              onChanged: (value) {
                // Handle radio button changes
              },
            ),
            RadioListTile(
              title: const Text('E-Wallet'),
              value: 'E-Wallet',
              groupValue: null,
              onChanged: (value) {
                // Handle radio button changes
              },
            ),
            // Add more RadioListTile widgets for other payment methods
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Implement checkout functionality
                  //nanti akan dibuat halaman selesai co
                },
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
