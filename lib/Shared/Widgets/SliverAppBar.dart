import 'dart:developer';

import 'package:dine/Models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import './../../ViewModels/MenuPageViewModel/menuPageViewModel.dart';

Widget createCustomSliverAppBar({
  required Restaurant restaurant,
  required ScrollController controller,
}) {
  log('length ${restaurant.tags?.length.toString()}');
  Widget customSliverAppBar = SliverAppBar(
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
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
                    itemCount: restaurant.tags?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      log('Sliverbar page tags ${restaurant.tags.toString()}');
                      return GestureDetector(
                        onTap: () {
                          log('anything? hui');
                          Scrollable.ensureVisible(
                              MenuPageViewModel.keys[index].currentContext!);
                          // controller?.scrollTo(
                          //     index: stamps?[restaurant.tags[index]] ?? 0,
                          //     duration: const Duration(seconds: 1));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4),
                            decoration: BoxDecoration(
                                // color: Colors.white,
                                border:
                                    Border.all(color: const Color(0xFFF4F4FF)),
                                borderRadius: BorderRadius.circular(4)),
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
                                Text(restaurant.tags![index],
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
                  Color(int.parse(restaurant.color ?? "0xFFFFFF")),
                  Colors.white
                ])),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: Image.network(restaurant.logo ?? ""),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(restaurant.name ?? "",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(
                  height: 4,
                ),
                Text("${restaurant.city}, ${restaurant.state}",
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
  log('anything?');
  return customSliverAppBar;
}
