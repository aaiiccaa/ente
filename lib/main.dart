import 'package:ente/dashboard_restaurant.dart';
import 'package:flutter/material.dart';
import 'login.dart'; // Pastikan ini mengarah ke lokasi file login yang benar

void main() {
  runApp(const WelcomeApp());
}

class WelcomeApp extends StatelessWidget {
  const WelcomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to ENTe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    // Menunda navigasi ke login selama 3 detik
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) { // Pastikan widget masih dalam tree
        // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const DashBoardRestaurant()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to ENTe',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Menambahkan warna untuk memastikan kontras
          ),
        ),
      ),
    );
  }
}
