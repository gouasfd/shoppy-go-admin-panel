import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppygo_adminepanel/logic/card_cubit/cubit/card_cubit.dart';
import 'package:shoppygo_adminepanel/models/product_model.dart';
import 'package:shoppygo_adminepanel/widgets/buyingcard.dart';
import 'package:shoppygo_adminepanel/widgets/empty_card.dart';

class wishlist extends StatelessWidget {
  const wishlist({super.key});
  final bool _empty = false;
  @override
  Widget build(BuildContext context) {
    CardCubit productCubit = BlocProvider.of<CardCubit>(context);

    return (productCubit.wishlist.isEmpty)
        ? const emptycard(
            pic: 'images/card/bag_wish.png',
            title: 'the card is empty',
            text: 'please buy something to make me happy',
          )
        : Scaffold(
            body: DynamicHeightGridView(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              itemCount: productCubit.wishlist.length,
              builder: (context, index) {
                return buyingcard(
                  productMod: ProductModule(
                      productImage: productCubit.wishlist[index].productImage,
                      productQuantity: '',
                      productId: '',
                      productTitle: productCubit.wishlist[index].productTitle,
                      productPrice: productCubit.wishlist[index].productPrice,
                      productCategory: '',
                      productDescription: ''),
                );
              },
            ),
          );
  }
}
