import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Network {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> get(String collection, String id) async {
    log("Getting Data from Collection : ${collection} \n DocId: ${id}");
    // set();
    DocumentSnapshot snap =
        await firestore.collection(collection).doc(id).get();
    Map<String, dynamic>? data = snap.data() as Map<String, dynamic>?;
    if (data == null) {
      log("NUll Value in Response");
      return {};
    }
    return data;
  }

  Future<void> add(String collection, Map<String, dynamic> data) async {
    await firestore.collection(collection).add(data);
  }

  set() {
    firestore.collection("Restaurants").doc("K7VvDwz4F7B5ka8VGoRn").set({
      "menu": [
        {
          "category": {
            "code": "456",
            "description": "Delicious Burgers",
            "name": "Burgers"
          },
          "code": "101",
          "description": "A juicy beef burger with cheese and bacon",
          "image": "https://example.com/burger1.jpg",
          "name": "Cheese Bacon Burger",
          "price": 950,
          "tags": [
            {
              "code": "201",
              "icon": "https://example.com/icons/beef.png",
              "name": "Beef"
            },
            {
              "code": "202",
              "icon": "https://example.com/icons/cheese.png",
              "name": "Cheese"
            }
          ]
        },
        {
          "category": {
            "code": "789",
            "description": "Exotic Pizzas",
            "name": "Pizzas"
          },
          "code": "202",
          "description": "A flavorful pizza with pepperoni and jalapenos",
          "image": "https://example.com/pizza1.jpg",
          "name": "Spicy Pepperoni Pizza",
          "price": 1200,
          "tags": [
            {
              "code": "301",
              "icon": "https://example.com/icons/pepperoni.png",
              "name": "Pepperoni"
            },
            {
              "code": "302",
              "icon": "https://example.com/icons/spicy.png",
              "name": "Spicy"
            }
          ]
        },
        {
          "category": {
            "code": "987",
            "description": "Refreshing Salads",
            "name": "Salads"
          },
          "code": "303",
          "description":
              "A healthy salad with mixed greens and grilled chicken",
          "image": "https://example.com/salad1.jpg",
          "name": "Grilled Chicken Salad",
          "price": 850,
          "tags": [
            {
              "code": "401",
              "icon": "https://example.com/icons/chicken.png",
              "name": "Chicken"
            },
            {
              "code": "402",
              "icon": "https://example.com/icons/healthy.png",
              "name": "Healthy"
            }
          ]
        },
        {
          "category": {
            "code": "654",
            "description": "Authentic Sushi",
            "name": "Sushi"
          },
          "code": "404",
          "description": "Fresh sushi rolls with tuna and avocado",
          "image": "https://example.com/sushi1.jpg",
          "name": "Tuna Avocado Sushi",
          "price": 1800,
          "tags": [
            {
              "code": "501",
              "icon": "https://example.com/icons/tuna.png",
              "name": "Tuna"
            },
            {
              "code": "502",
              "icon": "https://example.com/icons/avocado.png",
              "name": "Avocado"
            }
          ]
        },
        {
          "category": {
            "code": "321",
            "description": "Decadent Desserts",
            "name": "Desserts"
          },
          "code": "505",
          "description": "A rich chocolate cake with a molten lava center",
          "image": "https://example.com/dessert1.jpg",
          "name": "Molten Lava Cake",
          "price": 650,
          "tags": [
            {
              "code": "601",
              "icon": "https://example.com/icons/chocolate.png",
              "name": "Chocolate"
            },
            {
              "code": "602",
              "icon": "https://example.com/icons/sweet.png",
              "name": "Sweet"
            }
          ]
        }
      ]
    }, SetOptions(merge: true));
  }
}
