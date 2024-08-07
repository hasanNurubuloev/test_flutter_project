import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/router.dart';
import 'package:test_flutter_project/shared/custom_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _fieldTextLogin = TextEditingController();
  final _fieldTextPassword = TextEditingController();
  bool passwordVisible = false;
  bool _validateLogin = false;
  bool _validatePassword = false;

  @override
  void initState() {
    passwordVisible = true;
    super.initState();
  }

  String? validatePassword(String value) {
    if (!(value.length > 5) && value.isNotEmpty) {
      return "Password should contain more than 5 characters";
    }
    return null;
  }

  void _launchURL(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('home');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Sing In',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.mail_outline,
                  ),
                  labelText: 'Login',
                  errorText: _validateLogin ? 'Enter login' : null,
                ),
                controller: _fieldTextLogin,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: passwordVisible,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () => setState(
                              () => passwordVisible = !passwordVisible,
                            )),
                    labelText: 'Password',
                    errorText: _validatePassword ? 'Enter password' : null),
                controller: _fieldTextPassword,
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                      color: Colors.blue[400],
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue[400],
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 70,
                width: double.infinity,
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _validateLogin = _fieldTextLogin.text.isEmpty;
                        _validatePassword = _fieldTextPassword.text.isEmpty;
                      });
                      if (_fieldTextLogin.text == 'admin' &&
                          _fieldTextPassword.text == 'admin') {
                        context.goNamed(AppRoute.home.name);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue[700]!),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white)),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  'Don\'t have an account?',
                  style: TextStyle(color: Colors.blue[400], fontSize: 16),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: const Text('OR'),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 33,
                    onPressed: () {
                      _launchURL(
                          'https://www.facebook.com/profile.php?id=100012797834392');
                    },
                    icon: const Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL('https://mail.google.com/mail/u/0/#inbox');
                    },
                    icon: const Icon(
                      CustomIcons.gplus,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    iconSize: 33,
                    onPressed: () {
                      _launchURL('https://x.com/?lang=ru');
                    },
                    icon: const Icon(
                      CustomIcons.twitter,
                      color: Colors.blue,
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
