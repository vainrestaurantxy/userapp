import 'dart:convert';

import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:provider/provider.dart';

class CheckoutViewModel {
  getItemsAndAmount(context) {
    return MenuPageViewModel().getItemsAndAmount(context);
  }

  clearCart(context) {
    final repo = Provider.of<MenuPageData>(context, listen: false);
    repo.confirmOrder();
  }

  getCart(context)async{
    final repo = Provider.of<MenuPageData>(context, listen: false);
    String json = await getLocal(key: "cart");
    repo.cart = jsonDecode(json);
  }
}
