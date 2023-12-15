// import 'package:flutter/material.dart';

// class WishlistFormPage extends StatefulWidget {
//   const WishlistFormPage({Key? key}) : super(key: key);

//   @override
//   _WishlistFormPageState createState() => _WishlistFormPageState();
// }

// class _WishlistFormPageState extends State<WishlistFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   late Choice _selectedChoice;

//   @override
//   void initState() {
//     super.initState();
//     // Set an initial choice
//     _selectedChoice = PREFERENCE_CHOICES[0];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Center(
//           child: Text(
//             'Form Add To Wishlist',
//           ),
//         ),
//         backgroundColor: Colors.indigoAccent[100],
//         foregroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               Text(
//                 "How much do you like this book?",
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               Column(
//                 children: PREFERENCE_CHOICES.map((choice) {
//                   return RadioListTile<Choice>(
//                     title: Text(choice.label),
//                     value: choice,
//                     groupValue: _selectedChoice,
//                     onChanged: (Choice? value) {
//                       if (value != null) {
//                         setState(() {
//                           _selectedChoice = value;
//                         });
//                       }
//                     },
//                   );
//                 }).toList(),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.indigo),
//                 ),
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     // Perform the desired action with the selected preference
//                     print("Selected Preference: ${_selectedChoice.value}");

//                     // Add your logic here to send the data to Django
//                   }
//                 },
//                 child: const Text(
//                   "Save",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Choice {
// }

// class PREFERENCE_CHOICES {
// }
