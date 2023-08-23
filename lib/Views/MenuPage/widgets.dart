import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Models/tag.dart';

class Item extends ConsumerStatefulWidget {
  Item(
      {super.key,
      required this.image,
      required this.desc,
      required this.price,
      required this.name,
      required this.tags});
  String image, desc, name;
  int price;
  List<Tags> tags;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemState();
}

class _ItemState extends ConsumerState<Item> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 150,
        // width: double.infinity,
        child: Row(
          children: [
            Stack(
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
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xFF351985)),
                        color: Color(0xFFF4F4FF)),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      children: [
                        Text("Add",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 32,
                  width: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.tags.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xFF00632E),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Row(
                          children: [
                            Text(widget.tags[index].name,
                                style: TextStyle(
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
                    Text(widget.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    Text("INR ${widget.price}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(widget.desc,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8C8C8C),
                        fontWeight: FontWeight.w400,
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
