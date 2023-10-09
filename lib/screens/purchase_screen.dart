import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppygo_adminepanel/logic/card_cubit/cubit/card_cubit.dart';
import 'package:shoppygo_adminepanel/widgets/empty_card.dart';
import 'package:shoppygo_adminepanel/widgets/full_card.dart';

class Purchase extends StatelessWidget {
  const Purchase({super.key});

  @override
  Widget build(BuildContext context) {
    CardCubit cardCubit = BlocProvider.of<CardCubit>(context, listen: true);
    return cardCubit.cardproducts.isEmpty
        ? const emptycard(
            pic: 'images/card/customer.png',
            title: 'the card is empty',
            text: 'please buy something to make me happy',
          )
        : const fullcard();
  }
}
