import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layouts/shop_app/cubit/cubit.dart';
import 'package:shop/layouts/shop_app/cubit/states.dart';
import 'package:shop/shared/component/component.dart';
import 'package:shop/shared/component/constant.dart';


class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children:
                    [
                     if(state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextForm(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'name must not be empty';
                          }

                          return null;
                        },
                        Label: 'Name',
                        prefix: Icons.person,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextForm(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          }

                          return null;
                        },
                        Label: 'Email Address',
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultTextForm(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'phone must not be empty';
                          }

                          return null;
                        },
                        Label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: ()
                        {
                         // signOut(context);
                          if(formKey.currentState.validate())
                          {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        },
                        text: 'update',
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}