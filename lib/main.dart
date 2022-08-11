// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news%20app/cubit/cubit.dart';
import 'package:news_app/layout/news%20app/cubit/states.dart';
import 'package:news_app/layout/news%20app/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';

void main() {
  BlocOverrides.runZoned(
        () async{
      WidgetsFlutterBinding.ensureInitialized();
      await DioHelper.init();
      await CacheHelper.init();

      bool? isDark = CacheHelper.getBoolean(key: 'isDark');

      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness()
        ..changeAppMode(
          fromShared: isDark,
        ),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: darkTheme,
            theme: lightTheme,
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const NewsBottomNavBar(),
          );
        },
      ),
    );
  }
}
