import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business/business.dart';
import 'package:news/modules/science/science.dart';
import 'package:news/modules/sports/sports.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/shared_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> NavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
          Icons.business_center_rounded,
        ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_handball,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science_outlined,
      ),
      label: 'Science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(
    //     Icons.science_outlined,
    //   ),
    //   label: 'Science',
    // ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    // SettingsScreen(),
  ];

  void changeIndex(index)
  {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else {
      if (index == 2) getScience();
    }
    emit(AppChangeNavbarState());
  }

  List<dynamic> business = [];

  void getBusiness()
  {
    emit(NewsBuinessLoadnigState());

    if(business.length == 0 )
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'business',
              'apikey':'890ee3ce39e043969c521f3f1a94ff81',
            }
        ).then((value){
          business = value.data['articles'];
          emit(NewsGetBusinessSuccessState());
        }).catchError((error){
          emit(NewsGetBusinessErrorState(error));
          print(error.toString());
        });
      } else {
        emit(NewsGetBusinessSuccessState());
      }
  }

  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsSportsLoadnigState());

    if(sports.length == 0 )
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'sports',
              'apikey':'890ee3ce39e043969c521f3f1a94ff81',
            }
        ).then((value){
          sports = value.data['articles'];
          emit(NewsGetSportsSuccessState());
        }).catchError((error){
          emit(NewsGetSportsErrorState(error));
          print(error.toString());
        });
      } else {
        emit(NewsGetSportsSuccessState());
      }


  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsScienceLoadnigState());

    if(science.length == 0 )
      {
        DioHelper.getData(
            url: 'v2/top-headlines',
            query: {
              'country':'eg',
              'category':'science',
              'apikey':'890ee3ce39e043969c521f3f1a94ff81',
            }
        ).then((value){
          science = value.data['articles'];
          emit(NewsGetScienceSuccessState());
        }).catchError((error){
          emit(NewsGetScienceErrorState(error));
          print(error.toString());
        });
      } else {
        emit(NewsGetScienceSuccessState());
      }
  }

  List<dynamic> search = [];

  void getSearch(String value)
  {
    search = [];
    emit(NewsSearchLoadnigState());

      DioHelper.getData(
          url: 'v2/everything',
          query: {
            'q':'$value',
            'apikey':'890ee3ce39e043969c521f3f1a94ff81',
          }
      ).then((value){
        search = value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        emit(NewsGetSearchErrorState(error));
        print(error.toString());
      });
    }

}


class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void ChangeAppMode({bool? fromShared})
  {
    if(fromShared != null)
      {
        isDark = fromShared;
      } else{
        isDark = !isDark;
    }

    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(ChangeAppModeState());
    });


  }

}