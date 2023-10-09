import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppygo_adminepanel/consts/texts.dart';
import 'package:shoppygo_adminepanel/models/product_model.dart';
import 'package:shoppygo_adminepanel/widgets/mycard.dart';

import '../../logic/card_cubit/cubit/card_cubit.dart';

class allorders extends StatelessWidget {
  const allorders({super.key});

  @override
  Widget build(BuildContext context) {
    CardCubit cardCubit = BlocProvider.of<CardCubit>(context, listen: true);
    cardCubit.cardproducts;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const texts(
          text: 'placed order',
          big: true,
        ),
      ),
      body: ListView.builder(
        itemCount: cardCubit.cardproducts.length,
        itemBuilder: (context, index) {
          return Mycard(
            index: index,
            productModule: ProductModule(
                productImage: cardCubit.cardproducts[index].productImage,
                productQuantity: cardCubit.cardproducts[index].productQuantity,
                productId: cardCubit.cardproducts[index].productId,
                productTitle: cardCubit.cardproducts[index].productTitle,
                productPrice: cardCubit.cardproducts[index].productPrice,
                productCategory: '',
                productDescription: ''),
          );
        },
      ),
    );
  }
}
