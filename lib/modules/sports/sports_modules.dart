import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/bloc/cubit.dart';
import 'package:news/shared/bloc/state.dart';
import 'package:news/shared/widget/widgets.dart';

class SportsModules extends StatelessWidget {
  const SportsModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> sports = NewsCubit.get(context).sports;
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return defolteNewsScrean(sports[index], context);
            },
            separatorBuilder: (context, index) => Container(
                  color: Colors.grey,
                  height: 0.5,
                  margin: const EdgeInsets.only(left: 20.0),
                ),
            itemCount: sports.length);
      },
    );
  }
}
