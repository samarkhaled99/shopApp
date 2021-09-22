import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/layouts/shop_app/shop_layout.dart';
import 'package:shop/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop/modules/shop_app/login/cubit/states.dart';
import 'package:shop/modules/shop_app/register/shop_register_screen.dart';
import 'package:shop/shared/component/component.dart';
import 'package:shop/shared/component/constant.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit,shopLoginStates>(
        listener: (context,state){
          if(state is shopLoginSuccessStates){
            if(state.loginModel.status){
              print(state.loginModel.data.token);
              print(state.loginModel.data.id);
              print(state.loginModel.message);

              CacheHelper.saveData(key: 'token',
                  value:state.loginModel.data.token).then((value) {
                    token=state.loginModel.data.token;
                    navigateAndFinish(context, ShopLayout(),);
              });

            } else{
              print(state.loginModel.message);
              showToast(text: state.loginModel.message,
                  state: ToastStates.ERROR,);
            }
          }
        },
        builder: (context,state){
         return Scaffold(
            appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: (Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN', style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black
                        ),),
                        Text('Login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color:Colors.grey),
                        ),
                        SizedBox(height: 30.0,),
                        defaultTextForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            Label: 'Email Address',
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Email Address';
                              }
                            },
                            prefix: Icons.email_outlined),
                        SizedBox(height: 15.0,),
                        defaultTextForm(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            Label: 'Password',
                            suffix: ShopLoginCubit.get(context).suffix,
                            onSubmit: (value){
                              if(formKey.currentState.validate()){
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword:ShopLoginCubit.get(context).isPassword ,
                            suffixPressed: (){
                              ShopLoginCubit.get(context).changePasswordVisibility();
                            },
                            validate: (String value){
                              if(value.isEmpty){
                                return 'Please Enter Your Password';
                              }
                            },
                            prefix: Icons.lock_outline),
                        SizedBox(height: 30.0,),

                        Center(
                          child: ConditionalBuilder(
                            condition: state is! shopLoginLoadingStates,
                            builder: (context)=>defaultButton(text: 'login',
                              function: ()
                              {
                                if(formKey.currentState.validate()){
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }

                              },
                              isUpperCase: true,),
                            fallback: (context)=>CircularProgressIndicator(),
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            SizedBox(width: 5.0,),
                            defaultTextButton(function: (){
                              navigateTo(context, ShopRegisterScreen());
                            }, text: 'register')
                          ],),
                      ],
                    )),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
