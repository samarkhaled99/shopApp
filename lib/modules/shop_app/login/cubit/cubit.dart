import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/shop_app/login_model.dart';
import 'package:shop/modules/shop_app/login/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<shopLoginStates>{
  ShopLoginCubit() : super(shopLoginInitialStates());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
   ShopLoginModel loginModel;
  void userLogin({
  @required String email,
    @required String password,
}){
    emit(shopLoginLoadingStates());
    DioHelper.PostData(url: LOGIN, data: {
      'email':email,
      'password': password,
    }).then((value) {
      print(value.data);
    loginModel=  ShopLoginModel.fromJson(value.data);
      emit(shopLoginSuccessStates(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(shopLoginErrorStates(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){

    isPassword=!isPassword;
    suffix = isPassword ?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(shopChangePasswordVisibilityStates());
  }
}