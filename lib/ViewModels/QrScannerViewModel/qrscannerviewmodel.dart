import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Models/restaurantMenu.dart';
import 'package:provider/provider.dart';

class QrScannerViewModel {
  Future<bool> getRestaurant({required String id, required context}) async {
    var data = Provider.of<MenuPageData>(context, listen: false);
    await data.getRestaurant(id);
    if (data.restaurant == null) {
      return false;
    } else {
      return true;
    }
  }

  
}
