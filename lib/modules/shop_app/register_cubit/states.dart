abstract class ShopRegistersStates {}

class ShopRegisterInitialState extends ShopRegistersStates {}

class ShopRegisterLoadingState extends ShopRegistersStates {}

class ShopRegisterSuccessState extends ShopRegistersStates
{
  // final ShopRegisterMoShopRegisterModel;
  //
  // ShopRegisterSuccessState(tShopRegisterModel);
}

class ShopRegisterErrorState extends ShopRegistersStates
{
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopChangePasswordVisibilityState extends ShopRegistersStates {}
