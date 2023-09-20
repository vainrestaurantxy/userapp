import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:get_mac_address/get_mac_address.dart';
import 'package:provider/provider.dart';

import '../../Utils/Constants/staticConstants.dart';

class QrScannerViewModel {
  Future<bool> getRestaurant({required String id, required context}) async {
    var data = Provider.of<MenuPageData>(context, listen: false);
    await data.getRestaurant(id, context);
    if (data.restaurant == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getMacAdderess() async {
    final _getMacAddressPlugin = GetMacAddress();
    String macAdd = await _getMacAddressPlugin.getMacAddress() ?? "";
    Constants.macAddress = macAdd;
    return macAdd;
  }
}
