import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Network {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> get(String collection, String id) async {
   try{
    log("Getting Data from Collection : ${collection} \n DocId: ${id}");
    // set();
    Map<String, dynamic>? data;
    try {
      DocumentSnapshot snap =
          await firestore.collection(collection).doc(id).get();
      data = snap.data() as Map<String, dynamic>?;
    } catch (e) {
      log(e.toString());
    }

    if (data == null) {
      log("NUll Value in Response");
      return {};
    }
    return data;
   }
   catch(e){
     print("From Fetching Restaurants (Network.dart) $e");
   }

  }

  Future<void> add(String collection, Map<String, dynamic> data) async {
    await firestore.collection(collection).add(data);
  }

  set() {
    firestore.collection("Restaurants").add({
  "city": "New York",
  "logo": "logo2.jpeg",
  "name": "Gourmet Bites",
  "state": "New York",
  "tags": ["Burgers", "Sandwiches", "Pasta", "Seafood", "Cocktails"],
  "menu": [
    {
      "category": {
        "code": "123",
        "description": "Savory Burgers",
        "name": "Burgers"
      },
      "code": "101",
      "description": "A classic beef burger with caramelized onions",
      "image": "https://example.com/burger2.jpg",
      "name": "Caramelized Onion Burger",
      "price": 980,
      "tags": [
        {
          "code": "201",
          "icon": "https://example.com/icons/beef.png",
          "name": "Beef"
        },
        {
          "code": "203",
          "icon": "https://example.com/icons/onion.png",
          "name": "Onion"
        }
      ]
    },
    {
      "category": {
        "code": "234",
        "description": "Hearty Sandwiches",
        "name": "Sandwiches"
      },
      "code": "202",
      "description": "A turkey and cranberry sandwich on whole grain bread",
      "image": "https://example.com/sandwich1.jpg",
      "name": "Turkey Cranberry Sandwich",
      "price": 890,
      "tags": [
        {
          "code": "301",
          "icon": "https://example.com/icons/turkey.png",
          "name": "Turkey"
        },
        {
          "code": "302",
          "icon": "https://example.com/icons/cranberry.png",
          "name": "Cranberry"
        }
      ]
    },
    {
      "category": {
        "code": "345",
        "description": "Delicious Pasta",
        "name": "Pasta"
      },
      "code": "303",
      "description": "Creamy fettuccine Alfredo with grilled chicken",
      "image": "https://example.com/pasta1.jpg",
      "name": "Chicken Alfredo",
      "price": 1150,
      "tags": [
        {
          "code": "401",
          "icon": "https://example.com/icons/chicken.png",
          "name": "Chicken"
        },
        {
          "code": "402",
          "icon": "https://example.com/icons/pasta.png",
          "name": "Pasta"
        }
      ]
    },
    {
      "category": {
        "code": "456",
        "description": "Fresh Seafood",
        "name": "Seafood"
      },
      "code": "404",
      "description": "Grilled salmon with a lemon dill sauce",
      "image": "https://example.com/seafood1.jpg",
      "name": "Lemon Dill Salmon",
      "price": 1350,
      "tags": [
        {
          "code": "501",
          "icon": "https://example.com/icons/salmon.png",
          "name": "Salmon"
        },
        {
          "code": "502",
          "icon": "https://example.com/icons/lemon.png",
          "name": "Lemon"
        }
      ]
    },
    {
      "category": {
        "code": "567",
        "description": "Signature Cocktails",
        "name": "Cocktails"
      },
      "code": "505",
      "description": "A refreshing mojito with fresh mint and lime",
      "image": "https://example.com/cocktail1.jpg",
      "name": "Minty Mojito",
      "price": 750,
      "tags": [
        {
          "code": "601",
          "icon": "https://example.com/icons/mint.png",
          "name": "Mint"
        },
        {
          "code": "602",
          "icon": "https://example.com/icons/lime.png",
          "name": "Lime"
        }
      ]
    }
  ]
}
);
      }
}
