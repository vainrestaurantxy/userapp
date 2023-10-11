import 'dart:convert';
import 'dart:developer';

import 'package:dine/Models/restaurant.dart';
import 'package:dine/Shared/Widgets/AppBar.dart';
import 'package:dine/Shared/Widgets/SliverAppBar.dart';
import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:dine/Views/MenuPage/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' as prov;
import '../../Utils/Constants/staticConstants.dart';
import '../../Data/Repositories/MenuPage.dart';
import '../../ViewModels/QrScannerViewModel/qrscannerviewmodel.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({super.key, required this.id});
  final String id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  late Restaurant restaurant;
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final repo = prov.Provider.of<MenuPageData>(context, listen: false);
    QrScannerViewModel viewModel = QrScannerViewModel();
    List<Widget> items = [];
    repo.getRestaurant(widget.id, context);
    Constants.id = widget.id;

    return prov.Consumer<RestaurantBuilder>(
      builder: (context, ref, __) {
        if (repo.restaurant == null) {
          return const Scaffold(
              backgroundColor: (Colors.black),
              body: Center(
                child: Text("Nothing to show here"),
              ));
        }
        items = MenuPageViewModel().createMenu(repo.categoryDividedMenu!);
        // print("items:" + items.toString());
        //  print('ip addr ${Constants.macAddress}');
        restaurant = repo.restaurant!;
        List<String> genre = ['Veg', 'Non Veg', 'Drinks', 'Recommended', "Bestseller", "New"];
        Map<String,String> icons={
          "Veg":"assets/veg.svg",
          "Non Veg":"assets/non-veg.svg",
          "Drinks":"assets/drinks.svg",
          "Recommended":"assets/recommend.svg",
          "Bestseller":"assets/bestseller.svg",
          "New":"assets/new.svg",
        };
       // repo.getData(restaurant);
        log(Color(int.parse(restaurant.color!)).toString());
        return Scaffold(
          floatingActionButton: prov.Consumer<MenuPageData>(
            builder: (context, ref, child) {
              List<int> bottomData = MenuPageViewModel().getItemsAndAmount(context);
              return bottomData[0] == 0
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: GestureDetector(
                          onTap: () async{
                            setLocal(key: "cart", value: jsonEncode(ref.cart));
                            String mac = await viewModel.getMacAdderess();

                            repo.getUser(mac);
                            context.go("/menu/${Constants.id}/checkout");
                          },
                          child: Container(
                            width: 151,
                            height: 48,
                            decoration: BoxDecoration(
                                color: const Color(0xff88001f),
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.shopping_cart_outlined,
                                    color: Colors.white),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  'View Cart (${bottomData[0]})',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            },
          ),
          appBar: createAppBar(context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 212,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color(int.parse(restaurant.color!)),
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
                Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 130,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Filters',
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
                              itemCount: genre.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // log('Sliverbar page tags ${restaurant?.tags.toString()}');
                                return prov.Consumer<MenuPageViewModel>(
                                  builder: (context, ref, child) {
                                    // if (index < genre.length) {
                                    return GestureDetector(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            {
                                              if (MenuPageViewModel.boolTag ==
                                                  false) {
                                                MenuPageViewModel.boolTag =
                                                true;
                                                MenuPageViewModel.tag = "Veg";
                                                ref.selectedFilterIndex = index;
                                              } else {
                                                MenuPageViewModel.boolTag =
                                                false;
                                                MenuPageViewModel.tag = "";
                                                ref.selectedFilterIndex = -1;
                                              }
                                            }
                                            break;
                                          case 1:
                                            {
                                              if (MenuPageViewModel.boolTag ==
                                                  false) {
                                                MenuPageViewModel.boolTag =
                                                true;
                                                MenuPageViewModel.tag =
                                                "Non Veg";
                                                ref.selectedFilterIndex = index;
                                              } else {
                                                MenuPageViewModel.boolTag =
                                                false;
                                                MenuPageViewModel.tag = "";
                                                ref.selectedFilterIndex = -1;
                                              }
                                            }
                                            break;
                                          case 2:
                                            {
                                              if (MenuPageViewModel.boolTag ==
                                                  false) {
                                                MenuPageViewModel.boolTag =
                                                true;
                                                MenuPageViewModel.tag = "Drinks";
                                                ref.selectedFilterIndex = index;
                                              } else {
                                                MenuPageViewModel.boolTag =
                                                false;
                                                MenuPageViewModel.tag = "";
                                                ref.selectedFilterIndex = -1;
                                              }
                                            }
                                            break;
                                          case 3:
                                            {
                                              if (MenuPageViewModel.boolTag ==
                                                  false) {
                                                MenuPageViewModel.boolTag =
                                                true;
                                                MenuPageViewModel.tag =
                                                "Recommended";
                                                ref.selectedFilterIndex = index;
                                              } else {
                                                MenuPageViewModel.boolTag =
                                                false;
                                                MenuPageViewModel.tag = "";
                                                ref.selectedFilterIndex = -1;
                                              }
                                            }
                                            break;

                                          case 4:
                                            {
                                              if (MenuPageViewModel.boolTag ==
                                                  false) {
                                                MenuPageViewModel.boolTag =
                                                true;
                                                MenuPageViewModel.tag =
                                                "Bestseller";
                                                ref.selectedFilterIndex = index;
                                              } else {
                                                MenuPageViewModel.boolTag =
                                                false;
                                                MenuPageViewModel.tag = "";
                                                ref.selectedFilterIndex = -1;
                                              }
                                            }
                                            break;

                                          case 5:
                                            {
                                              if (MenuPageViewModel.boolTag ==
                                                  false) {
                                                MenuPageViewModel.boolTag =
                                                true;
                                                MenuPageViewModel.tag =
                                                "New";
                                                ref.selectedFilterIndex = index;
                                              } else {
                                                MenuPageViewModel.boolTag =
                                                false;
                                                MenuPageViewModel.tag = "";
                                                ref.selectedFilterIndex = -1;
                                              }
                                            }
                                            break;
                                          default:
                                            {
                                              if (MenuPageViewModel.boolTag ==
                                                  false) {
                                                MenuPageViewModel.boolTag =
                                                true;
                                                MenuPageViewModel.tag = "";
                                                ref.selectedFilterIndex = index;
                                              } else {
                                                MenuPageViewModel.boolTag =
                                                false;
                                                MenuPageViewModel.tag = "";
                                                ref.selectedFilterIndex = -1;
                                              }
                                            }
                                            break;
                                        }
                                        // if (index == 0) {
                                        //     if(  MenuPageViewModel.boolTag==false){
                                        //       MenuPageViewModel.boolTag=true;
                                        //       MenuPageViewModel.tag = "Veg";
                                        //       ref.selectedFilterIndex=index;
                                        //     } else{
                                        //       MenuPageViewModel.boolTag=false;
                                        //       MenuPageViewModel.tag = "Veg";
                                        //       ref.selectedFilterIndex=-1;
                                        //     }
                                        // }
                                        // else if (index == 1) {
                                        //   //
                                        //   if(  MenuPageViewModel.boolTag==false){
                                        //     MenuPageViewModel.boolTag=true;
                                        //     MenuPageViewModel.tag = "Non Veg";
                                        //     ref.selectedFilterIndex=index;
                                        //   }else {
                                        //     MenuPageViewModel.boolTag = false;
                                        //     MenuPageViewModel.tag = "Non Veg";
                                        //     ref.selectedFilterIndex=-1;
                                        //   }
                                        // }

                                        // else if (index == 2) {
                                        //   ref.selectedFilterIndex = 2;
                                        //   MenuPageViewModel.tag =
                                        //       "Recommended";
                                        // }
                                        final provider =
                                            prov.Provider.of<RestaurantBuilder>(
                                                context,
                                                listen: false);
                                        provider.notifyListeners();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4),
                                          decoration: BoxDecoration(
                                              color: ref.selectedFilterIndex == index &&
                                                      MenuPageViewModel.boolTag == true
                                                  ? Color(0xff88001f)
                                                  : Colors.transparent,
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFFF4F4FF)),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          child: Row(
                                            children: [
                                                SvgPicture.asset(
                                                icons[genre[index]]!,
                                                width: 20,
                                                height: 20,
                                                color:ref.selectedFilterIndex ==
                                                    index &&
                                                    MenuPageViewModel
                                                        .boolTag ? Colors.white:null
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(genre[index],
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color:
                                                        ref.selectedFilterIndex !=
                                                                index
                                                            ? Colors.black
                                                            : Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                    // else {
                                    //   final resIndex = index - genre.length;
                                    //   return GestureDetector(
                                    //     onTap: () {
                                    //       // print(MenuPageViewModel.keys);
                                    //       ref.selectedFilterIndex = -1;
                                    //       ref.notifyListeners();
                                    //     },
                                    //     child: Padding(
                                    //       padding: const EdgeInsets.symmetric(
                                    //           horizontal: 4.0),
                                    //       child: Container(
                                    //         padding: const EdgeInsets.symmetric(
                                    //             horizontal: 8.0, vertical: 4),
                                    //         decoration: BoxDecoration(
                                    //             border: Border.all(
                                    //                 color: const Color(
                                    //                     0xFFF4F4FF)),
                                    //             borderRadius:
                                    //                 BorderRadius.circular(4)),
                                    //         child: Row(
                                    //           children: [
                                    //             SvgPicture.asset(
                                    //               "assets/fastfood.svg",
                                    //               width: 20,
                                    //               height: 20,
                                    //             ),
                                    //             const SizedBox(
                                    //               width: 10,
                                    //             ),
                                    //             Text(
                                    //                 restaurant!.tags![resIndex],
                                    //                 style: const TextStyle(
                                    //                   fontSize: 12,
                                    //                   color: Colors.black,
                                    //                   fontWeight:
                                    //                       FontWeight.w500,
                                    //                 ))
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   );
                                    // }
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
                Column(
                  children:
                      List.generate(items.length, (index) => items[index]),
                ),
                //   CustomScrollView(controller: controller, slivers: [
                //     SliverAppBar(
                //     automaticallyImplyLeading: false,
                //     floating: false,
                //     expandedHeight: 355,
                //     elevation: 0,
                //     pinned: true,
                //     collapsedHeight: 130,
                //     flexibleSpace: FlexibleSpaceBar(
                //       expandedTitleScale: 1,
                //       titlePadding: const EdgeInsets.all(0),
                //       title: Container(
                //         color: Colors.white,
                //         width: double.infinity,
                //         height: 130,
                //         child: Padding(
                //           padding:
                //           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                //           child: Column(
                //             children: [
                //
                //               const SizedBox(
                //                 height: 50,
                //               ),
                //
                //               Align(
                //                 alignment: Alignment.bottomLeft,
                //                 child: Text(
                //                   'Categories & Filters',
                //                   style: GoogleFonts.poppins(
                //                       fontSize: 16,
                //                       fontWeight: FontWeight.w500,
                //                       color: Colors.black),
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 8,
                //               ),
                //
                //               SizedBox(
                //                 height: 32,
                //                 width: double.infinity,
                //                 child: Center(
                //                   child: ListView.builder(
                //                     controller: controller,
                //                     itemCount: (restaurant?.tags?.length ?? 0) + genre.length,
                //                     scrollDirection: Axis.horizontal,
                //                     itemBuilder: (context, index) {
                //                        // log('Sliverbar page tags ${restaurant?.tags.toString()}');
                //                       return prov.Consumer<MenuPageViewModel>(
                //                         builder: (context, ref, child) {
                //                           if (index < genre.length) {
                //                             return GestureDetector(
                //                               onTap: () {
                //                                 // print("filter");
                //                                 if (index == 0) {
                //                                   if (ref.selectedFilterIndex != 0) {
                //                                     ref.selectedFilterIndex = 0;
                //                                     MenuPageViewModel.tag = "";
                //                                   } else {
                //                                     ref.selectedFilterIndex = -1;
                //                                     MenuPageViewModel.tag = "Veg";
                //                                   }
                //                                 } else if (index == 1) {
                //                                   if (ref.selectedFilterIndex != 1) {
                //                                     ref.selectedFilterIndex = 1;
                //                                     MenuPageViewModel.tag = "";
                //                                   } else {
                //                                     ref.selectedFilterIndex = -1;
                //                                     MenuPageViewModel.tag = "Non Veg";
                //                                   }
                //                                 } else if (index == 2) {
                //                                   ref.selectedFilterIndex = 2;
                //                                   MenuPageViewModel.tag = "Recommended";
                //                                 }
                //                                 final provider =
                //                                 prov.Provider.of<RestaurantBuilder>(
                //                                     context,
                //                                     listen: false);
                //                                 provider.notifyListeners();
                //
                //                               },
                //                               child: Padding(
                //                                 padding: const EdgeInsets.symmetric(
                //                                     horizontal: 4.0),
                //                                 child: Container(
                //                                   padding: const EdgeInsets.symmetric(
                //                                       horizontal: 8.0, vertical: 4),
                //                                   decoration: BoxDecoration(
                //                                       color:
                //                                       ref.selectedFilterIndex == index
                //                                           ? Color(0xff323232)
                //                                           : Colors.transparent,
                //                                       border: Border.all(
                //                                           color: const Color(0xFFF4F4FF)),
                //                                       borderRadius:
                //                                       BorderRadius.circular(4)),
                //                                   child: Row(
                //                                     children: [
                //                                       ref.selectedFilterIndex != index
                //                                           ? SvgPicture.asset(
                //                                         "assets/fastfood.svg",
                //                                         width: 20,
                //                                         height: 20,
                //                                       )
                //                                           : Image.asset(
                //                                         'assets/fastfoodwhite.png',
                //                                         height: 20,
                //                                         width: 20,
                //                                       ),
                //                                       const SizedBox(
                //                                         width: 10,
                //                                       ),
                //                                       Text(genre[index],
                //                                           style: TextStyle(
                //                                             fontSize: 12,
                //                                             color:
                //                                             ref.selectedFilterIndex !=
                //                                                 index
                //                                                 ? Colors.black
                //                                                 : Colors.white,
                //                                             fontWeight: FontWeight.w500,
                //                                           ))
                //                                     ],
                //                                   ),
                //                                 ),
                //                               ),
                //                             );
                //                           } else {
                //                             final resIndex = index - genre.length;
                //                             return GestureDetector(
                //                               onTap: () {
                //                                 // print(MenuPageViewModel.keys);
                //                                 ref.selectedFilterIndex = -1;
                //                                 ref.notifyListeners();
                //                               },
                //                               child: Padding(
                //                                 padding: const EdgeInsets.symmetric(
                //                                     horizontal: 4.0),
                //                                 child: Container(
                //                                   padding: const EdgeInsets.symmetric(
                //                                       horizontal: 8.0, vertical: 4),
                //                                   decoration: BoxDecoration(
                //                                       border: Border.all(
                //                                           color: const Color(0xFFF4F4FF)),
                //                                       borderRadius:
                //                                       BorderRadius.circular(4)),
                //                                   child: Row(
                //                                     children: [
                //                                       SvgPicture.asset(
                //                                         "assets/fastfood.svg",
                //                                         width: 20,
                //                                         height: 20,
                //                                       ),
                //                                       const SizedBox(
                //                                         width: 10,
                //                                       ),
                //                                       Text(restaurant!.tags![resIndex],
                //                                           style: const TextStyle(
                //                                             fontSize: 12,
                //                                             color: Colors.black,
                //                                             fontWeight: FontWeight.w500,
                //                                           ))
                //                                     ],
                //                                   ),
                //                                 ),
                //                               ),
                //                             );
                //                           }
                //                         },
                //                       );
                //                     },
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //       collapseMode: CollapseMode.parallax,
                //       background: Stack(
                //         children: [
                //           Container(
                //             decoration: BoxDecoration(
                //                 gradient: LinearGradient(
                //                     begin: Alignment.topCenter,
                //                     end: Alignment.center,
                //                     colors: [
                //                       Color(int.parse(restaurant?.color ?? "0xFFFFFF")),
                //                       Colors.white
                //                     ])),
                //           ),
                //           SizedBox(
                //             width: double.infinity,
                //             child: Column(
                //               children: [
                //                 const SizedBox(
                //                   height: 100,
                //                 ),
                //                 SizedBox(
                //                   width: 100,
                //                   height: 50,
                //                   child: Image.network(restaurant?.logo ?? ""),
                //                 ),
                //                 const SizedBox(
                //                   height: 8,
                //                 ),
                //                 Text(restaurant?.name ?? "",
                //                     style: const TextStyle(
                //                       fontSize: 24,
                //                       color: Colors.black,
                //                       fontWeight: FontWeight.w600,
                //                     )),
                //                 const SizedBox(
                //                   height: 4,
                //                 ),
                //                 Text("${restaurant?.city}, ${restaurant?.state}",
                //                     style: const TextStyle(
                //                       fontSize: 13,
                //                       color: Colors.black,
                //                       fontWeight: FontWeight.w400,
                //                     )),
                //               ],
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                // ),
                //
                //   ]),
                //   SizedBox(
                //       width: double.infinity,
                //       height: 84,
                //       child: createAppBar(context)),
              ],
            ),
          ),
        );
      },
    );
  }
}
