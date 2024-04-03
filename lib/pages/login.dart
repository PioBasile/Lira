import 'package:flutter/material.dart';
import 'package:test/components/inputbox.dart';
import 'package:test/components/buttonbox.dart';

class Login extends StatefulWidget {
  final void Function() onTap;

  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() {
    //add authentication here
    Navigator.pushNamed(context, '/home');
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //logo
                Image.asset(
                  'lib/images/LIRA Logo - Original with Transparent Background - cropped.png',
                  width: 350,
                  height: 350,
                ),

                //input boxes
                const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 0),
                InputBox(
                    controller: usernameController,
                    hintText: 'username',
                    obscureText: false,
                    obligatory: true),

                const SizedBox(height: 25),
                InputBox(
                    controller: passwordController,
                    hintText: 'password',
                    obscureText: true,
                    obligatory: true),

                const SizedBox(height: 20),
                Center(
                  child: ButtonBox(
                    text: 'Login',
                    onTap: () {
                      login();
                    },
                  ),
                ),

                const SizedBox(height: 15),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? ",
                          style: TextStyle(
                            color: Color.fromARGB(255, 130, 118, 118),
                            fontSize: 15,
                          )),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                              color: Color.fromARGB(255, 206, 201, 201),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
