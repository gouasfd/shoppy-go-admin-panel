import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:shoppygo_adminepanel/utils/sharedpref.dart';

part 'themechange_state.dart';

class ThemechangeCubit extends Cubit<ThemechangeState> {
  ThemechangeCubit() : super(ThemechangeInitial());

  bool isdark = false;

  // Initialize isdark value from SharedPreferences
  void init() {
    isdark = CacheData.getData('theme') ?? false;
    emit(ThemechangeInitial());
  }

  void changetheme() async {
    isdark = !isdark;

    CacheData.setData('theme', isdark);

    emit(Themechange());
  }
}
