import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:get_mac_address/get_mac_address.dart';
import 'package:provider/provider.dart';

import '../../Utils/Constants/staticConstants.dart' as constant;

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
    var ipAddress = IpAddress();
    dynamic data = await ipAddress.getIpAddress();
    constant.Constants.macAddress = data;
    return data;
  }
}
