abstract class NewsState {}

class NwesInatiolState extends NewsState {}

class NwesBottomNavState extends NewsState {}

class NewsLodingDataState extends NewsState {}

class NewsGetScssecDataState extends NewsState {}

class NewsGetErrorDataState extends NewsState {
  final String? error;

  NewsGetErrorDataState(this.error);
}

class NewsLodingSearchState extends NewsState {}

class NewsGetSearchScssecDataState extends NewsState {}

class NewsGetSearchErrorDataState extends NewsState {
  final String? error;

  NewsGetSearchErrorDataState(this.error);
}

class NewsThemModeState extends NewsState {}
