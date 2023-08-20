import 'package:flutter/material.dart';

void main() {
  runApp(WelcomeScreen());
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/img1.jpg'),
              fit: BoxFit.contain,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text('Log In'),
                  ),
                ),
              ),
              Container(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text('Register'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
