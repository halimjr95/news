import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultFormFied(
                    type: TextInputType.text,
                    controller: searchController,
                    validate: (String? value)
                    {
                      if(value!.isEmpty)
                      {
                        return "Search can not be empty !!!";
                      }
                      return null;
                    },
                    onChange: (value) {
                      NewsCubit.get(context).getSearch(value);
                    },
                    label: 'Search',
                    prefix: Icons.search),
              ),
              Expanded(
                  child: BuildListOfArticle(list),
              ),
            ],
          ),
        );
      },
    );
  }
}
