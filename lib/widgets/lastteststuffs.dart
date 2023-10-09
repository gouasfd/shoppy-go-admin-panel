import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppygo_adminepanel/consts/texts.dart';
import 'package:shoppygo_adminepanel/logic/card_cubit/cubit/card_cubit.dart';
import 'package:shoppygo_adminepanel/models/product_model.dart';
import 'package:shoppygo_adminepanel/widgets/heart_button.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key, this.productModule});
  final ProductModule? productModule;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/discription',
              arguments: productModule);
        },
        child: SizedBox(
          width: size.width * 0.45,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FancyShimmerImage(
                    imageUrl: productModule!.productImage,
                    height: size.width * 0.24,
                    width: size.width * 0.32,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Flexible(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      productModule!.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          heart(
                            color: Colors.transparent,
                            size: 19,
                          ),
                          IconButton(
                            onPressed: () {
                              BlocProvider.of<CardCubit>(context)
                                  .addproduct(productModule!);
                            },
                            icon: const Icon(
                              Icons.add_shopping_cart,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: texts(
                        text: productModule!.productPrice.toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
