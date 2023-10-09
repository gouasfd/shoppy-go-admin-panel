import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppygo_adminepanel/consts/themes.dart';
import 'package:shoppygo_adminepanel/firebase_options.dart';
import 'package:shoppygo_adminepanel/logic/card_cubit/cubit/card_cubit.dart';
import 'package:shoppygo_adminepanel/logic/product_cubit/cubit/product_cubit.dart';
import 'package:shoppygo_adminepanel/logic/themebloc/cubit/themechange_cubit.dart';
import 'package:shoppygo_adminepanel/screens/inner_screens/all_orders_screen.dart';
import 'package:shoppygo_adminepanel/screens/inner_screens/Upload_product_Screen.dart';
import 'package:shoppygo_adminepanel/screens/inner_screens/discription.dart';
import 'package:shoppygo_adminepanel/screens/inner_screens/latest_view.dart';
import 'package:shoppygo_adminepanel/screens/inner_screens/wishlist.dart';
import 'package:shoppygo_adminepanel/screens/panels_screen.dart';
import 'package:shoppygo_adminepanel/screens/purchase_screen.dart';
import 'package:shoppygo_adminepanel/screens/search_screen.dart';
import 'package:shoppygo_adminepanel/utils/sharedpref.dart';
import 'package:shoppygo_adminepanel/widgets/forget_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CacheData.initializeShared();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ThemechangeCubit(),
      ),
      BlocProvider(
        create: (context) => CardCubit(),
        child: Container(),
      ),
      BlocProvider(
        create: (context) => ProductCubit(),
        child: Container(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemechangeCubit theme =
        BlocProvider.of<ThemechangeCubit>(context, listen: true);

    theme.init();
    return MaterialApp(
      routes: {
        '/Upload': (context) => const UploadProducts(),
        'purchase': (context) => const Purchase(),
        '/search': (context) => const Search(),
        '/discription': (context) => const discription(),
        '/wishlist': (context) => const wishlist(),
        '/latestview': (context) => const latestview(),
        '/allorders': (context) => const allorders(),
        '/forget': (context) => const forgetpassword(),
      },
      title: 'Flutter Demo',
      theme: theme.isdark ? Themes.lighttheme : Themes.darktheme,
      home: const MyHomePage(),
    );
  }
}
