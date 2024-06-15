import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'service/auth_service.dart'; // Pastikan untuk membuat dan mengimpor auth_service.dart
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _register() async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      // Show error message if passwords do not match
      print('Passwords do not match');
      return;
    }

    try {
      print('Eksekusi auth service');
      final result = await AuthService().register(
          'Your Name', email, password); // Add your name or create a name field
      print('hasil response successful: ${result}');
      print('Registration successful: ${result['token']}');
      // Save token and navigate to login screen or dashboard
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      print('Registration failed: $e');
      // Show error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sblk.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Opacity(
                opacity: _opacity.value,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    buildTextField('Email', controller: emailController),
                    SizedBox(height: 16),
                    buildTextField('Password',
                        controller: passwordController, obscureText: true),
                    SizedBox(height: 16),
                    buildTextField('Confirm Password',
                        controller: confirmPasswordController,
                        obscureText: true),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _register,
                      child: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    buildRichText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String hint,
      {bool obscureText = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      obscureText: obscureText,
    );
  }

  RichText buildRichText() {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: <TextSpan>[
          TextSpan(text: "Already have an account? "),
          TextSpan(
            text: 'Log in',
            style: TextStyle(
                color: Colors.red, decoration: TextDecoration.underline),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
          ),
        ],
      ),
    );
  }
}
