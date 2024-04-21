// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:test/components/inputbox.dart';
import 'package:test/components/buttonbox.dart';
import 'package:test/services/auth/auth_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();

  void register() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _authservice = AuthService();

    if (passwordController.text.isEmpty || usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fields cannot be empty')),
      );
      return;
    }

    if (passwordController.text != password2Controller.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      await _authservice.registerWithEmailAndPassword(
          usernameController.text, passwordController.text);
      Navigator.pushNamed(context, '/firsttime');
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Error'),
          content: Text('Failed to register: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  //forgot password
  void forgotPass(){
    final authservice = AuthService();
    if(usernameController.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }
    try{
      authservice.resetPassword(usernameController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Reset Password Error'),
          content: Text('Failed to reset password: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _goToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 18, 18),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 40),
                InputBox(
                  controller: usernameController,
                  hintText: 'Email',
                  obscureText: false,
                  obligatory: true
                ),
                const SizedBox(height: 20),
                InputBox(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  obligatory: true
                ),
                const SizedBox(height: 20),
                InputBox(
                  controller: password2Controller,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  obligatory: true
                ),
                const SizedBox(height: 40),
                ButtonBox(
                  text: 'Register',
                  onTap: register,
                ),
                TextButton(
                  // ignore: avoid_print
                  onPressed: () => forgotPass(),
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _goToLogin,
                  child: const Text(
                    'Already have an account? Log in now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
