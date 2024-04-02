import 'package:flutter/material.dart';

class ButtonBox extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const ButtonBox({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap : onTap,
      // ignore: avoid_unnecessary_containers
      child: Container(
        width: 350,
        height: 50,
        decoration: BoxDecoration(
          color:const Color.fromARGB(255, 64, 64, 64),
          borderRadius: BorderRadius.circular(10),
        ),
        child:Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
