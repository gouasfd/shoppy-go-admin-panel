import 'package:flutter/material.dart';
import 'package:shoppygo_adminepanel/consts/texts.dart';

class costumcard extends StatelessWidget {
  const costumcard(
      {super.key, required this.image, required this.text, this.function});
  final String image;
  final String text;
  final function;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                width: 100,
                height: 100,
              ),
              texts(
                text: text,
                middle: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
