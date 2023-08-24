import 'package:dine/Shared/Widgets/AppBar.dart';
import 'package:dine/Shared/Widgets/SliverAppBar.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as prov;
import '../../Data/Repositories/MenuPage.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  List<dynamic> keys = [];
  ScrollController controller = ScrollController();
  List<Widget> items = [];
  @override
  Widget build(BuildContext context) {
    final repo = prov.Provider.of<MenuPageData>(context, listen: false);
    items = MenuPageViewModel().createMenu(repo.categoryDividedMenu!);
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomScrollView(controller: controller, slivers: [
            createCustomSliverAppBar(
                restaurant: repo.restaurant!, controller: controller),
            SliverToBoxAdapter(
                child: Column(
              children: List.generate(items.length, (index) => items[index]),
            )),
          ]),
          SizedBox(width: double.infinity, height: 84, child: customAppbar)
        ],
      ),
    );
  }
}
