import 'dart:developer';

import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Models/restaurant.dart';
import 'package:dine/Views/MenuPage/menuPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' as prov;

import './../../ViewModels/MenuPageViewModel/menuPageViewModel.dart';

Widget createCustomSliverAppBar({
  required Restaurant? rest,
  required ScrollController? controller,
}) {
  // log('length ${restaurant.tags?.length.toString()}');
  List<String> genre = ['Veg', 'Non Veg'];
  //List<String> selectedTags = [];
  Widget customSliverAppBar = prov.Consumer<MenuPageData>(
    builder: (context, res, child) {
      final restaurant = res.restaurant;
      log('length of res.tags is ${restaurant?.tags?.length.toString()}');
      return SliverAppBar(
        automaticallyImplyLeading: false,
        floating: false,
        expandedHeight: 350,
        elevation: 0,
        pinned: true,
        collapsedHeight: 125,
        flexibleSpace: FlexibleSpaceBar(
          expandedTitleScale: 1,
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            color: Colors.white,
            width: double.infinity,
            height: 125,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                children: [
                  // SizedBox(
                  //     width: double.infinity,
                  // child: TextFormField(
                  //   decoration: InputDecoration(
                  //     hintText: "Search in Menu",
                  //     disabledBorder: OutlineInputBorder(
                  //         borderSide:
                  //             BorderSide(color: Color(0xFFF4F4FF), width: 0),
                  //         borderRadius: BorderRadius.all(Radius.circular(12))),
                  //     enabledBorder: OutlineInputBorder(
                  //         borderSide:
                  //             BorderSide(color: Color(0xFFF4F4FF), width: 0),
                  //         borderRadius: BorderRadius.all(Radius.circular(12))),
                  //     errorBorder: OutlineInputBorder(
                  //         borderSide:
                  //             BorderSide(color: Color(0xFFF4F4FF), width: 0),
                  //         borderRadius: BorderRadius.all(Radius.circular(12))),
                  //     border: OutlineInputBorder(
                  //         borderSide:
                  //             BorderSide(color: Color(0xFFF4F4FF), width: 0),
                  //         borderRadius: BorderRadius.all(Radius.circular(12))),
                  //     filled: true,
                  //     fillColor: Color(0xFFF4F4FF),
                  //   ),
                  // )),
                  const SizedBox(
                    height: 35,
                  ),

                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Categories & Filters',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  SizedBox(
                    height: 32,
                    width: double.infinity,
                    child: Center(
                      child: ListView.builder(
                        controller: controller,
                        itemCount:
                            (restaurant?.tags?.length ?? 0) + genre.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          log('Sliverbar page tags ${restaurant?.tags.toString()}');
                          return prov.Consumer<MenuPageViewModel>(
                            builder: (context, ref, child) {
                              if (index < genre.length) {
                                return GestureDetector(
                                  onTap: () {
                                    // print("filter");
                                    if (index == 0) {
                                      if (MenuPageViewModel.tag != "Veg") {
                                        MenuPageViewModel.tag = "Veg";
                                      } else {
                                        MenuPageViewModel.tag = "";
                                      }
                                    } else {
                                      if (MenuPageViewModel.tag != "Non Veg") {
                                        MenuPageViewModel.tag = "Non Veg";
                                      } else {
                                        MenuPageViewModel.tag = "";
                                      }
                                    }
                                    // ref.tag = "${}";
                                    print(ref.selectedTags);
                                    final provider =
                                        prov.Provider.of<RestaurantBuilder>(
                                            context,
                                            listen: false);
                                    provider.notifyListeners();
                                    // log('anything? hui');
                                    // Scrollable.ensureVisible(MenuPageViewModel
                                    //     .keys[index].currentContext!);

                                    // controller?.scrollTo(
                                    //     index: stamps?[restaurant.tags[index]] ?? 0,
                                    //     duration: const Duration(seconds: 1));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFFF4F4FF)),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/fastfood.svg",
                                            width: 20,
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(genre[index],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                final resIndex = index - genre.length;
                                return GestureDetector(
                                  onTap: () {
                                    // print(MenuPageViewModel.keys);
                                    Scrollable.ensureVisible(MenuPageViewModel
                                        .keys[restaurant.tags![resIndex]]!
                                        .currentContext!);
                                    // controller?.scrollTo(
                                    //     index: stamps?[restaurant.tags[index]] ?? 0,
                                    //     duration: const Duration(seconds: 1));
                                    // if (!ref.selectedTags
                                    //     .contains(restaurant.tags)) {
                                    //   ref.selectedTags
                                    //       .add(restaurant.tags![resIndex]);
                                    //   log('haha selectedtag ${ref.selectedTags.toString()}');
                                    //   res.notifyListeners();
                                    // } else {
                                    //   ref.selectedTags
                                    //       .remove(restaurant.tags![resIndex]);
                                    //   res.notifyListeners();
                                    // }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFFF4F4FF)),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/fastfood.svg",
                                            width: 20,
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(restaurant!.tags![resIndex],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          collapseMode: CollapseMode.parallax,
          background: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                      Color(int.parse(restaurant?.color ?? "0xFFFFFF")),
                      Colors.white
                    ])),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: Image.network(restaurant?.logo ?? ""),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(restaurant?.name ?? "",
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        )),
                    const SizedBox(
                      height: 4,
                    ),
                    Text("${restaurant?.city}, ${restaurant?.state}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  log('anything?');
  return customSliverAppBar;
}
