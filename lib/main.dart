import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layouts/shop_app/shop_layout.dart';
import 'package:shop/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop/shared/component/constant.dart';
import 'package:shop/shared/cubits/cubit.dart';
import 'package:shop/shared/cubits/states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/styles/themes.dart';


import 'layouts/shop_app/cubit/cubit.dart';
import 'modules/shop_app/login/shop_login_screen.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized(); //عشان يخلي الابلكسشن ي init قبل ميعمل runapp
 DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getData(key:'isDark');
  Widget widget;
  bool onBoarding = CacheHelper.getData(key:'onBoarding');
  token= CacheHelper.getData(key: 'token');
 print(token);
  if(onBoarding != null){
    if(token!=null)widget= ShopLayout();
    else widget = ShopLoginScreen();
  }
  else {
    widget=OnBoardingScreen();
  }
  print(onBoarding);
  runApp(MyApp(
      isDark:isDark,
      startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp({this.isDark,this.startWidget});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       //BlocProvider(create: (context)=>NewsCubit()..getBusiness(),),
        BlocProvider(create:(BuildContext context)=> AppCubit()..changeAppMode(
         fromShared: isDark,
        ),),
        BlocProvider(create:(BuildContext context)=> ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder:(context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            //onBoarding? ShopLoginScreen(): OnBoardingScreen()

            theme:lightTheme,
          //  darkTheme: darkTheme,
          //  themeMode: AppCubit.get(context).isDark ?ThemeMode.dark:ThemeMode.light,

          );
        },
      ),
    );

  }
}




