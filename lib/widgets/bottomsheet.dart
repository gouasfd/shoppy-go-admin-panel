import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppygo_adminepanel/consts/texts.dart';
import 'package:shoppygo_adminepanel/logic/card_cubit/cubit/card_cubit.dart';

class bottomsheet extends StatelessWidget {
  const bottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    CardCubit cardCubit = BlocProvider.of<CardCubit>(context, listen: true);
    String mydouble = cardCubit.totalprice.toStringAsFixed(2);
    return SizedBox(
      height: kBottomNavigationBarHeight,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                texts(
                  text: 'total(${cardCubit.totalproducts})',
                  middle: true,
                ),
                texts(
                  text: '${mydouble}da',
                  color: Colors.blue,
                )
              ],
            ),
            ElevatedButton(
                onPressed: () {}, child: const texts(text: 'checkout'))
          ],
        ),
      ),
    );
  }
}
