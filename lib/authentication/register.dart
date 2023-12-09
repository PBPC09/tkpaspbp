import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lembarpena/authentication/login_page.dart';


class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedRole = 'buyer';


  Future<void> _registerUser() async { // nunggu yang login TKT SALAHHH
    final url = Uri.parse("http://localhost:8000/auth/register/"
    // final url = Uri.parse("https://lembarpena-c09-tk.pbp.cs.ui.ac.id/auth/register/"
        );
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},  // Set the content type to JSON
      body: jsonEncode ({
        'username': _usernameController.text,
        'email': _emailController.text,
        'password1':
            _passwordController.text,
        'password2':
            _passwordController.text, 
        'role' :
          _selectedRole,
      },
    ));

    if (response.statusCode == 200) {
      // Handle successful registration
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User registered successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => LoginPage(),
                  ));
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle registration errors
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to register user.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),

            DropdownButtonFormField<String>(
              value: _selectedRole,
              items: const [
                DropdownMenuItem<String>(
                  value: 'buyer',
                  child: Text('Buyer'),
                ),
                DropdownMenuItem<String>(
                  value: 'admin',
                  child: Text('Admin'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedRole = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Role',
              ),
            ),
            const SizedBox(height: 24.0),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                await _registerUser();
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
