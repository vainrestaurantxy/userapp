import 'package:flutter/material.dart';

import '../../Data/Repositories/MenuPage.dart';

getAddButton({required String code, required MenuPageData ref}) {
  return ref.cart[code] == 0 || ref.cart[code] == null
      ? GestureDetector(
          onTap: () => ref.addOnTap(code: code),
          child: Container(
            width: 70,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color(0xFF351985)),
                color: const Color(0xFFF4F4FF)),
            child: Center(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Add",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ))
                ],
              ),
            ),
          ),
        )
      : Container(
         width: 70,
            height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xFF351985)),
              color: Color(0xFFF4F4FF)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      ref.subOnTap(code: code);
                    },
                    child: Icon(
                      Icons.remove,
                      size: 20,
                    )),
                // IconButton(onPressed: (){ref.addOnTap(code: code);}, icon: Icon(Icons.add)),
                Text("${ref.cart[code]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    )),
                GestureDetector(
                    onTap: () {
                      ref.addOnTap(code: code);
                    },
                    child: Icon(
                      Icons.add,
                      size: 20,
                    )),
                // IconButton(onPressed: (){ref.subOnTap(code: code);}, icon: Icon(Icons.remove)),
              ],
            ),
          ),
        );
}
