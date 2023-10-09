import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppygo_adminepanel/consts/texts.dart';
import 'package:shoppygo_adminepanel/models/product_model.dart';
import 'package:uuid/uuid.dart';
import 'package:shoppygo_adminepanel/widgets/ImagePicker.dart';
import 'package:uuid/uuid.dart';

class UploadProducts extends StatefulWidget {
  const UploadProducts({super.key});

  @override
  State<UploadProducts> createState() => _UploadProductsState();
}

class _UploadProductsState extends State<UploadProducts> {
  late TextEditingController _titlecontroller;
  late TextEditingController _discriptioncontroller;
  late TextEditingController _pricecontroller;
  late TextEditingController _quantitycontroller;
  @override
  void initState() {
    _titlecontroller = TextEditingController();
    _discriptioncontroller = TextEditingController();
    _pricecontroller = TextEditingController();
    _quantitycontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _discriptioncontroller.dispose();
    _titlecontroller.dispose();
    _quantitycontroller.dispose();
    _pricecontroller.dispose();
  }

  XFile? _pickedimage;
  final ImagePicker _imagepicker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await _imagepicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _pickedimage = pickedImage;
      });
    }
    Navigator.pop(context); // Close the AlertDialog
  }

  List<String> _items = [
    'phones',
    'laptops',
    'watches',
    'shoes',
    'Accessories',
  ];
  bool thereispic = false;
  String firstitem = 'phones';
  final _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final ProductModule? productModule =
        ModalRoute.of(context)?.settings.arguments as ProductModule?;
    if (productModule != null) {
      _discriptioncontroller.text = productModule.productDescription;
      _titlecontroller.text = productModule.productTitle;
      _quantitycontroller.text = productModule.productQuantity;
      _pricecontroller.text = productModule.productPrice;
      thereispic = true;
    }

    void _validproduct() async {
      if (_globalKey.currentState!.validate()) {
        if (_pickedimage != null) {
          try {
            var ref = FirebaseStorage.instance
                .ref()
                .child('productimage')
                .child('mypicture.jpg');
            await ref.putFile(File(_pickedimage!.path));
            var imageurl = await ref.getDownloadURL();

            var storage =
                FirebaseFirestore.instance.collection('products').doc('1245');
            await storage.set({
              'title': _titlecontroller.text.trim(),
              'price': _pricecontroller.text.trim(),
              'quantity': _quantitycontroller.text.trim(),
              'description': _discriptioncontroller.text.trim(),
              'category': firstitem,
              'image': imageurl,
            });
          } catch (e) {
            // Handle any exceptions that may occur during Firebase operations
            print("Error: $e");
            // You can also show an error message to the user if needed.
          }
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('images/card/shopping_basket.png'),
                  SizedBox(
                    height: 10,
                  ),
                  texts(text: 'Add a picture please'),
                ],
              ),
            ),
          );
        }
      }
    }

    return Form(
      key: _globalKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload new products'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: InkWell(
                            onTap:
                                _pickImageFromGallery, // Call the function to pick an image
                            child: Container(
                              child: const Text('Pick from gallery'),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Imagepicker(
                    picture: productModule != null
                        ? productModule.productImage
                        : null,
                    pic: thereispic,
                    pickerdimage: _pickedimage,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  hint: texts(text: 'enter the categorie'),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  focusColor: Colors.grey,
                  items: _items
                      .map((e) =>
                          DropdownMenuItem(value: e, child: texts(text: e)))
                      .toList(),
                  onChanged: (newval) {
                    setState(() {
                      productModule != null
                          ? firstitem == productModule.productCategory
                          : firstitem = newval!;
                    });
                  },
                  value: firstitem,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _titlecontroller,
                    maxLength: 80,
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      hintText: 'product title',
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _pricecontroller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey,
                            hintText: 'price',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _quantitycontroller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey,
                            hintText: 'qty',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _discriptioncontroller,
                    minLines: 5,
                    maxLines: 8,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      hintText: 'product discription',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.cancel),
                                texts(
                                  text: 'cancel',
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            _validproduct();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.upload),
                              texts(
                                text: 'upload product',
                                color: Colors.white,
                              ),
                            ],
                          )),
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
