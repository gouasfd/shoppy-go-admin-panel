import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppygo_adminepanel/consts/texts.dart';
import 'package:shoppygo_adminepanel/logic/themebloc/cubit/themechange_cubit.dart';
import 'package:shoppygo_adminepanel/widgets/costum_card.dart';
import 'package:shoppygo_adminepanel/widgets/theme_switcher.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemechangeCubit theme =
        BlocProvider.of<ThemechangeCubit>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          actions: const [
            theme_switcher(),
          ],
          backgroundColor: theme.isdark ? Colors.white : Colors.black,
          title: const texts(
            text: 'shoppy go admin',
            middle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            children: [
              costumcard(
                image: 'images/card/order.png',
                text: 'add new product',
                function: () {
                  Navigator.pushNamed(context, '/Upload');
                },
              ),
              costumcard(
                  image: 'images/card/customer.png',
                  text: 'view Orders',
                  function: () {
                    Navigator.pushNamed(context, 'purchase');
                  }),
              costumcard(
                  image: 'images/card/bag_wish.png',
                  text: 'inspect all the products',
                  function: () {
                    Navigator.pushNamed(context, '/search');
                  }),
            ],
          ),
        ));
  }
}
