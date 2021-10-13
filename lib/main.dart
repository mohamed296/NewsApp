import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:news/layout/news_layout.dart';
import 'package:news/shared/bloc/bloc_observer.dart';
import 'package:news/shared/bloc/cubit.dart';
import 'package:news/shared/bloc/state.dart';
import 'package:news/shared/network/local/shared_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SharedHelper.init();
  bool? isDark = SharedHelper.getData(key: 'isDark');

  runApp(MyApp(
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    this.isDark,
  }) : super(key: key);
  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..themMode(fromShared: isDark)
        ..getBusiness(category: 'business')
        ..getBusiness(category: 'science')
        ..getBusiness(category: 'sports'),
      child: BlocConsumer<NewsCubit, NewsState>(
          builder: (context, state) {
            return MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                ),
                scaffoldBackgroundColor: Colors.white,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: Colors.black87,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0,
                ),
                iconTheme: const IconThemeData(color: Colors.deepOrange),
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.deepOrange,
                appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white),
                  titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black87,
                    statusBarIconBrightness: Brightness.light,
                  ),
                  backgroundColor: Colors.black87,
                  elevation: 0.0,
                ),
                scaffoldBackgroundColor: Colors.black87,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: Colors.white,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0,
                  backgroundColor: Colors.black87,
                ),
                iconTheme: const IconThemeData(color: Colors.deepOrange),
                textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              themeMode: NewsCubit.get(context).isdark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: const NewsLayout(),
            );
          },
          listener: (context, state) {}),
    );
  }
}
