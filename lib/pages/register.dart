import 'package:flutter/material.dart';
import 'package:test/components/inputbox.dart';
import 'package:test/components/buttonbox.dart';
import 'package:test/services/auth/auth_service.dart';

class Register extends StatefulWidget {
  final void Function()? onTap;

  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController maximumdayController = TextEditingController();
  final TextEditingController bankamountController = TextEditingController();


  void register() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _authservice = AuthService();

    //check if password is empty
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password cannot be empty'),
        ),
      );
      return;
    }

    //check if username is empty
    if (usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username cannot be empty'),
        ),
      );
      return;
    }

    //check if bankamount is empty
    if (bankamountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bank amount cannot be empty'),
        ),
      );
      return;
    }

    //check if maximumday is empty
    if (maximumdayController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maximum day cannot be empty'),
        ),
      );
      return;
    }

    try {
      await _authservice.registerWithEmailAndPassword(
          usernameController.text, passwordController.text);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/home');
    } 
    catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context, 
        builder: (context) =>
        AlertDialog(
          title: const Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 17, 17, 17),
        body: Center(
          child: SizedBox(
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                //input boxes
                const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 20),
                InputBox(
                    controller: usernameController,
                    hintText: 'email',
                    obscureText: false,
                    obligatory: true),

                const SizedBox(height: 20),
                InputBox(
                    controller: passwordController,
                    hintText: 'password',
                    obscureText: true,
                    obligatory: true),

                const SizedBox(height: 20),
                InputBox(
                    controller: bankamountController,
                    hintText: 'money in your bank',
                    obscureText: false,
                    obligatory: true,
                    keyboardType: "number",
                ),
                  
                const SizedBox(height: 20),
                InputBox(
                    controller: maximumdayController,
                    hintText: 'maximumum spending per day',
                    obscureText: false,
                    obligatory: true),

                const SizedBox(height: 20),
                InputBox(
                    controller: categoryController,
                    hintText: 'categories',
                    obscureText: false,
                    obligatory: false,
                    keyboardType: "number",
                ),

                const SizedBox(height: 20),
                Center(
                  child: ButtonBox(
                    text: 'Register',
                    onTap: () {
                      register();
                    },
                  ),
                ),

                const SizedBox(height: 15),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 118, 118),
                            fontSize: 15,
                          )),
                      GestureDetector(
                        onTap: _goToLogin,
                        child: const Text(
                          'Log in now',
                          style: TextStyle(
                              color: Color.fromARGB(255, 206, 201, 201),
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 30),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color.fromARGB(255, 150, 40, 40), 
                      size: 16, 
                    ),
                    SizedBox(width: 4), 
                    Text(
                      'Please note that your information are encrypted and stored securely.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 114, 103, 103),
                        fontSize: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
