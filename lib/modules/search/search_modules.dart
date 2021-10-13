import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/bloc/cubit.dart';
import 'package:news/shared/bloc/state.dart';
import 'package:news/shared/widget/widgets.dart';

class SearchModules extends StatelessWidget {
  SearchModules({Key? key}) : super(key: key);
  final TextEditingController searchControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
        builder: (context, state) {
          List<dynamic> search = NewsCubit.get(context).search;
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: searchControler,
                    onFieldSubmitted: (value) {
                      log(value.toString());
                      NewsCubit.get(context).getSearch(value: value);
                    },
                    // onChanged: (value) {
                    //   // searchControler.text = value.toString();
                    //   log(value.toString());
                    //   NewsCubit.get(context).getSearch(value: value.toString());
                    // },
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.3),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      labelText: "Search",
                      labelStyle: const TextStyle(color: Colors.blueGrey),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.blueGrey,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Pleas Enter Your Text";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  state is! NewsLodingSearchState
                      ? Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return defolteNewsScrean(
                                    search[index], context);
                              },
                              separatorBuilder: (context, index) => Container(
                                    color: Colors.grey,
                                    height: 0.5,
                                    margin: const EdgeInsets.only(left: 20.0),
                                  ),
                              itemCount: search.length),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
