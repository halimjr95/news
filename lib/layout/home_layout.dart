import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/search/search.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/remote/dio_helper.dart';


class HomeLayout extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 25.0,
            title: Text(
              'News'
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.brightness_4,
                ),
                onPressed: () {
                  AppCubit.get(context).ChangeAppMode();
                  print(AppCubit.get(context).isDark);
                },
              ),
            ],
          ),
          // floatingActionButton: FloatingActionButton(
          //   child: Icon(
          //     Icons.add,
          //   ),
          //   onPressed: () {},
          // ),
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.NavBarItems,
            currentIndex: cubit.currentIndex,
            onTap: (index)
            {
              cubit.changeIndex(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }


}
