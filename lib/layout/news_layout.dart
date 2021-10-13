import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/search/search_modules.dart';
import 'package:news/shared/bloc/cubit.dart';
import 'package:news/shared/bloc/state.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text("News App"),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => SearchModules(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    cubit.themMode();
                  },
                  icon:
                      Icon(cubit.isdark ? Icons.light_mode : Icons.dark_mode)),
            ],
          ),
          body: state is! NewsLodingDataState
              ? cubit.modules[cubit.currentIndex]
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.bottomNavigator(index: index);
            },
            items: cubit.bottomNav,
          ),
        );
      },
    );
  }
}
