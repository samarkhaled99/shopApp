import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layouts/shop_app/cubit/cubit.dart';
import 'package:shop/layouts/shop_app/cubit/states.dart';
import 'package:shop/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop/modules/shop_app/search/search_screen.dart';
import 'package:shop/shared/component/component.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder: (context,state){
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Salla',),
      actions: [IconButton(onPressed:() {
        navigateTo(context, SearchScreen());
      }, icon:Icon(Icons.search))],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              cubit.changebottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),
            label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),
                  label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),
                  label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),
                  label: 'Setting'),
            ],
          ),
        );
      },
    );
  }
}
