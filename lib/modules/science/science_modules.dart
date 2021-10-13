import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/bloc/cubit.dart';
import 'package:news/shared/bloc/state.dart';
import 'package:news/shared/widget/widgets.dart';

class ScienceModules extends StatelessWidget {
  const ScienceModules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<dynamic> scince = NewsCubit.get(context).science;
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return defolteNewsScrean(scince[index], context);
            },
            separatorBuilder: (context, index) => Container(
                  color: Colors.grey,
                  height: 0.5,
                  margin: const EdgeInsets.only(left: 20.0),
                ),
            itemCount: scince.length);
      },
    );
  }
}
