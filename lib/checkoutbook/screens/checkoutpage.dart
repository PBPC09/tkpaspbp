import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:lembarpena/Main/screens/menu.dart';
import 'dart:convert';
import 'package:lembarpena/authentication/login_page.dart';
import 'package:lembarpena/buybooks/models/cart_item.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:lembarpena/buybooks/screens/cart_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _deliveryGroupValue = '';
  String _paymentGroupValue = '';
  late String uname = LoginPage.uname;
  late Future<double> harga;
  double valueHarga = 0;
  TextEditingController alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    harga = fetchHarga();
  }

  Future<List<CartItem>> getCartItems() {
    return fetchProduct();
  }

  Future<double> fetchHarga() async {
    var url = Uri.parse(
        'http:///127.0.0.1:8000/checkoutbook/get_total_harga/$uname/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    var hargaStr =
        data[0]['total_harga']; // Mengakses nilai dalam array bertingkat
    var harga = double.tryParse(hargaStr) ??
        0.0; // Mengonversi ke double, default ke 0.0 jika gagal
    return harga;
  }

  Future<List<CartItem>> fetchProduct() async {
    var url = Uri.parse(
        'http:///127.0.0.1:8000/checkoutbook/show_checkout_json/$uname/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

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
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.indigo[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCartItemsSection(),
              buildTotalPriceSection(),
              buildAddressInput(),
              buildDeliveryOptionsSection(),
              buildPaymentOptionsSection(),
              buildCheckoutButton(request),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCartItemsSection() {
    return FutureBuilder<List<CartItem>>(
      future: getCartItems(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error.toString()}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Tidak ada barang di keranjang.');
        } else {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: snapshot.data!.map((item) {
                return ListTile(
                  title: Text(item.title, style: const TextStyle(fontSize: 18)),
                  subtitle: Text('Quantity: ${item.quantity}'),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  Widget buildTotalPriceSection() {
    return FutureBuilder<double>(
      future: harga,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          valueHarga = snapshot.data!;
          return Text('Total Harga: SAR ${snapshot.data}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));
        }
      },
    );
  }

  Widget buildAddressInput() {
    return TextFormField(
      controller: alamatController,
      decoration: const InputDecoration(
        labelText: 'Alamat Pengiriman',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }

  Widget buildDeliveryOptionsSection() {
    List<Map<String, String>> deliveryOptions = [
      {"title": "Reguler", "value": "Reguler"},
      {"title": "Express", "value": "Express"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih jenis pengiriman',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: deliveryOptions.map((option) {
            return RadioListTile(
              title:
                  Text(option['title']!, style: const TextStyle(fontSize: 16)),
              value: option['value']!,
              groupValue: _deliveryGroupValue,
              onChanged: (value) =>
                  setState(() => _deliveryGroupValue = value as String),
              activeColor: Colors.deepPurple,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildPaymentOptionsSection() {
    List<Map<String, String>> paymentOptions = [
      {"title": "Kartu Debit", "value": "Kartu Debit"},
      {"title": "Kartu Kredit", "value": "Kartu Kredit"},
      {"title": "Transfer Bank", "value": "Transfer Bank"},
      {"title": "E-Wallet", "value": "E-Wallet"}
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih metode pembayaran',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          children: paymentOptions.map((option) {
            return RadioListTile(
              title:
                  Text(option['title']!, style: const TextStyle(fontSize: 16)),
              value: option['value']!,
              groupValue: _paymentGroupValue,
              onChanged: (value) =>
                  setState(() => _paymentGroupValue = value as String),
              activeColor: Colors.deepPurple,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildCheckoutButton(CookieRequest request) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ElevatedButton(
        onPressed: () => handleCheckout(request),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo[900],
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: const Text(
          'Checkout',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  void handleCheckout(CookieRequest request) async {
    if (_deliveryGroupValue.isEmpty) {
      // Menampilkan pesan jika metode pembayaran belum dipilih
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih jenis pengiriman')),
      );
      return;
    }
    if (_paymentGroupValue.isEmpty) {
      // Menampilkan pesan jika metode pembayaran belum dipilih
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih metode pembayaran')),
      );
      return;
    }

    if (alamatController.text.isEmpty) {
      // Menampilkan pesan jika alamat belum diisi
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan isi alamat pengiriman')),
      );
      return;
    }

    try {
      final response = await request.postJson(
        "http:///127.0.0.1:8000/checkoutbook/checkout_flutter/",
        jsonEncode({
          "alamat": alamatController.text,
          "metode_pengiriman": _deliveryGroupValue,
          "metode_pembayaran": _paymentGroupValue,
          "total_harga": valueHarga,
        }),
      );

      // Menangani respons dari server
      if (response['status'] == 'success') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Berhasil Checkout'),
              content: const Text('Terima kasih telah berbelanja!'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Kembali'),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CartPage()),
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        // Menampilkan pesan error
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response['message']}")),
        );
      }
    } catch (e) {
      // Menangani error pada saat request
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }
}
