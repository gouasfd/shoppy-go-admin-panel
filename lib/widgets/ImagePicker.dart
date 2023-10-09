import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppygo_adminepanel/models/product_model.dart';

class Imagepicker extends StatelessWidget {
  const Imagepicker(
      {super.key, this.pickerdimage, required this.pic, this.picture});
  final XFile? pickerdimage;
  final bool pic;
  final String? picture;
  @override
  Widget build(BuildContext context) {
    return pic == true
        ? Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.width * 0.3,
            decoration:
                BoxDecoration(border: Border.all(width: 2, color: Colors.blue)),
            child: Image.network(picture!),
          )
        : pickerdimage == null
            ? Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blue)),
                child: const Icon(Icons.image),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                child: Image.file(File(pickerdimage!.path)),
              );
  }
}
