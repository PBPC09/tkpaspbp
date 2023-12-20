import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lembarpena/AdminRegisterBook/screens/admin_menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:lembarpena/authentication/register.dart';
import 'package:lembarpena/Main/screens/menu.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String uname = "";

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background-3.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: FadeInUp(
                        duration: const Duration(seconds: 1),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1200),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-2.png'))),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1300),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/clock.png'))),
                        ),
                      ),
                    ),
                    Positioned(
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1600),
                        child: Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: const Duration(milliseconds: 1800),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color.fromRGBO(
                                              143, 148, 251, 1)))),
                              child: TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Username",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700])),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color.fromRGBO(
                                              143, 148, 251, 1)))),
                              child: TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "Password",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[700])),
                                obscureText: true,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: ElevatedButton(
                        onPressed: () async {
                          String username = _usernameController.text;
                          String password = _passwordController.text;

                          // Cek kredensial
                          // Untuk menyambungkan Android emulator dengan Django pada localhost,
                          // gunakan URL http://10.0.2.2/
                          final response = await request.login(
                              "https://lembarpena-c09-tk.pbp.cs.ui.ac.id/auth/login/",
                              {
                                'username': username,
                                'password': password,
                              });

                          if (request.loggedIn) {
                            String message = response['message'];
                            LoginPage.uname = response['username'];
                            String uname = LoginPage.uname;
                            if (response['logged_in_as'] == 'Buyer') {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()),
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminPage()),
                              );
                            }
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(SnackBar(
                                  content: Text(
                                      "$message Selamat datang, $uname.")));
                          } else {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Login Gagal'),
                                content: Text(response['message']),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationPage()),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                              color: Colors.black), // Default text color
                          children: <TextSpan>[
                            TextSpan(text: "Don't have an account yet? "),
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration
                                      .underline), // Special style for "Sign up"
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
