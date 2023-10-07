import 'dart:developer';

import 'package:dine/Data/Repositories/MenuPage.dart';
import 'package:dine/Shared/Widgets/cartButton.dart';
import 'package:dine/ViewModels/MenuPageViewModel/menuPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as prov;

import '../../Models/tag.dart';

class Item extends ConsumerStatefulWidget {
  Item(
      {super.key,
      required this.image,
      required this.desc,
      required this.price,
      required this.name,
      required this.code,
      required this.tags});
  String image, desc, name;
  int price;
  String code;
  List<String> tags;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemState();
}

class _ItemState extends ConsumerState<Item> {
  @override
  Widget build(BuildContext context) {
    final repo = prov.Provider.of<MenuPageViewModel>(context, listen: false);
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width - 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width - 35) * 0.25,
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    width: 132,
                    height: 132,
                  ),
                ),
                Positioned(
                  bottom: -7,
                  child: prov.Consumer<MenuPageData>(
                    builder: (context, ref, child) {
                      return getAddButton(name: widget.name, ref: ref);
                    },
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
           SizedBox(
              width: ((MediaQuery.of(context).size.width - 35) * 0.75) - 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32,
                    width: (MediaQuery.of(context).size.width / 428) * 252 - 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.tags.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0xFF00632E),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Row(
                            children: [
                              Text(widget.tags[index],
                                  style: const TextStyle(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 428) * 252 -
                            60,
                        child: Text(widget.name,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width / 428) * 252 -
                            60,
                        child: Text("AED ${widget.price}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width / 428) * 252 - 60,
                    child: Text(widget.desc,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8C8C8C),
                          fontWeight: FontWeight.w400,
                        )),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
