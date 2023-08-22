import '../../Models/restaurant.dart';
import '../../Models/restaurantMenu.dart';

class MenuPageViewModel {
  Map<String,List<RestaurantMenu>> reArrangeCategory({required Restaurant restaurant}) {

    Map<String, List<RestaurantMenu>> categoryDividedMenu = {};
    for (var item in restaurant.menu) {
      if (categoryDividedMenu[item.category.name] == null) {
        categoryDividedMenu[item.category.name] = [];
      }
      categoryDividedMenu[item.category.name]!.add(item);
    }
    return categoryDividedMenu;
  }
}
