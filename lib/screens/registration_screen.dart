import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static String route = '/registration';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  String email = '', password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: _isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: kTagLogo,
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                textAlign: TextAlign.center,
                style: kFormInputTextStyle,
                decoration: kFormInputDecoration.copyWith(
                  hintText: 'Enter your email.',
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                textAlign: TextAlign.center,
                style: kFormInputTextStyle,
                decoration: kFormInputDecoration.copyWith(
                  hintText: 'Enter your password.',
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                label: 'Register',
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    var credentials =
                        await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    print(credentials.user!.email);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      //TODO: replace print with UI message
                      print('The passowrd provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      //TODO: replace print with UI message
                      print('The email provided is already in use.');
                    }
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    _isLoading = false;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
