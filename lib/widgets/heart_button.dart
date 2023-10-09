import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppygo_adminepanel/logic/card_cubit/cubit/card_cubit.dart';
import 'package:shoppygo_adminepanel/models/product_model.dart';

class heart extends StatefulWidget {
  heart(
      {super.key,
      this.color = Colors.blue,
      this.size = 30,
      this.productModule});
  final double size;
  final color;
  ProductModule? productModule;
  @override
  State<heart> createState() => _heartState();
}

class _heartState extends State<heart> {
  Color _heartcolor = Colors.black;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<CardCubit>(context)
            .addtowishlist(widget.productModule!);
        setState(() {
          _heartcolor = Colors.red;
        });
      },
      child: Container(
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
        child: Center(
            child: Icon(
          Icons.heart_broken,
          color: _heartcolor,
        )),
      ),
    );
  }
}
