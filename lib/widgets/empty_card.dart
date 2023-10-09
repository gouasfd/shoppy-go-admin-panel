import 'package:flutter/material.dart';
import 'package:shoppygo_adminepanel/consts/texts.dart';

class emptycard extends StatelessWidget {
  const emptycard(
      {super.key, required this.pic, required this.title, required this.text});
  final String pic;
  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120,
            ),
            Image.asset(
              pic,
              width: 280,
            ),
            const SizedBox(
              height: 10,
            ),
            const texts(
              text: 'whoops',
              color: Colors.red,
              big: true,
            ),
            texts(
              text: title,
              middle: true,
            ),
            texts(
              text: text,
              middle: true,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: const texts(
                  text: 'shop now',
                  middle: true,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
