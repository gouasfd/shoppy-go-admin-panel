import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shoppygo_adminepanel/consts/texts.dart';
import 'package:shoppygo_adminepanel/logic/card_cubit/cubit/card_cubit.dart';
import 'package:shoppygo_adminepanel/logic/themebloc/cubit/themechange_cubit.dart';
import 'package:shoppygo_adminepanel/models/product_model.dart';
import 'package:shoppygo_adminepanel/widgets/bottomsheet.dart';
import 'package:shoppygo_adminepanel/widgets/mycard.dart';

class fullcard extends StatelessWidget {
  const fullcard({super.key});

  @override
  Widget build(BuildContext context) {
    ThemechangeCubit theme =
        BlocProvider.of<ThemechangeCubit>(context, listen: true);
    CardCubit cardCubit = BlocProvider.of<CardCubit>(context);

    return Scaffold(
      bottomSheet: const bottomsheet(),
      appBar: AppBar(
        title: Shimmer.fromColors(
          baseColor: Colors.purple,
          highlightColor: Colors.red,
          child: const texts(
            text: 'shoppy go',
            middle: true,
          ),
        ),
        backgroundColor:
            theme.isdark == false ? Colors.grey[800] : Colors.white,
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
