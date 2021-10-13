import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business/business_modules.dart';
import 'package:news/modules/science/science_modules.dart';
import 'package:news/modules/sports/sports_modules.dart';
import 'package:news/shared/bloc/state.dart';
import 'package:news/shared/network/local/shared_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NwesInatiolState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomNav = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Scince",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.sports_baseball),
      label: "Sports",
    ),
  ];
  List<Widget> modules = [
    const BusinessModules(),
    const ScienceModules(),
    const SportsModules(),
  ];
  void bottomNavigator({required int index}) {
    currentIndex = index;
    emit(NwesBottomNavState());
  }

  bool isdark = false;

  void themMode({bool? fromShared}) {
    if (fromShared != null) {
      isdark = fromShared;
      emit(NewsThemModeState());
    } else {
      isdark = !isdark;
      SharedHelper.putData(key: "isDark", value: isdark).then((value) {
        emit(NewsThemModeState());
      });
    }
  }

  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];

  void getBusiness({required String category}) {
    emit(NewsLodingDataState());
    if (business.isEmpty && science.isEmpty && sports.isEmpty) {
      DioHelper.getData(url: "v2/top-headlines", query: {
        'country': 'us',
        'category': category,
        'apiKey': '870bab11d57f45799c367fc69935c730'
      }).then((value) {
        if (category == 'business') {
          business = value.data['articles'];
          emit(NewsGetScssecDataState());
          log(business[0]['title'].toString());
        }
        if (category == 'science') {
          science = value.data['articles'];
          emit(NewsGetScssecDataState());
          log("science : ${science[1]['title']}");
        }
        if (category == 'sports') {
          sports = value.data['articles'];
          emit(NewsGetScssecDataState());
          log(sports[0]['title'].toString());
        }
      }).catchError((e) {
        emit(NewsGetErrorDataState(e.toString()));
        log("error get Data $e");
      });
    } else {
      emit(NewsGetScssecDataState());
    }
  }

  List<dynamic> search = [];
  void getSearch({required String value}) {
    emit(NewsLodingSearchState());
    DioHelper.getData(
            url: "v2/everything",
            query: {'q': value, 'apiKey': '870bab11d57f45799c367fc69935c730'})
        .then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchScssecDataState());
    }).catchError((e) {
      emit(NewsGetSearchErrorDataState("Error search $e"));
    });
  }
}
