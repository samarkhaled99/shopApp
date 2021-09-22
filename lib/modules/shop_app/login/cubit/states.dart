import 'package:shop/models/shop_app/login_model.dart';

abstract class shopLoginStates{}
class shopLoginInitialStates extends shopLoginStates{}
class shopLoginLoadingStates extends shopLoginStates{}
class shopLoginSuccessStates extends shopLoginStates{
  final ShopLoginModel loginModel;

  shopLoginSuccessStates(this.loginModel);
}
class shopLoginErrorStates extends shopLoginStates{
  final String error;
  shopLoginErrorStates(this.error);
}
class shopChangePasswordVisibilityStates extends shopLoginStates{

}


