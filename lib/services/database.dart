import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/item_chooser.dart';

Future<void> updateMenuQuantity(UserConnect user, int count, int index) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  await _firestore
      .collection('group')
      .where('groupId', isEqualTo: user.groupId)
      .get()
      .then((value) {
    var key = user.menuQuantity.keys.elementAt(index);
    user.menuQuantity[key] = count + user.menuQuantity[key]!;

    if (user.menuQuantity[key]! < 0) {
      user.menuQuantity[key] = 0;
    }

    List<dynamic> tmp = value.docs.first.data()['menuQuantity'];
    List<dynamic> users = value.docs.first.data()['users'];
    tmp[users.indexOf(user.name)] = user.menuQuantity;
    _firestore
        .collection('group')
        .doc(value.docs.first.id)
        .update({'menuQuantity': tmp});
  });
}

Future<List<TotalMenuQuantity>> getTotalQuantity(UserConnect user) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TotalMenuQuantity> total = [];

  try {
    await _firestore
        .collection('group')
        .where('groupId', isEqualTo: user.groupId)
        .get()
        .then(
      (value) {
        List<dynamic> tmp = value.docs.first.data()['menuQuantity'];
        List<dynamic> users = value.docs.first.data()['users'];
        List<dynamic> menu = value.docs.first.data()['menu'];

        for (var i = 0; i < menu.length; i++) {
          Map<String, int> tmpMap = {};
          int quantity = 0;
          for (var j = 0; j < tmp.length; j++) {
            tmpMap[users[j]] = tmp[j][menu[i]];
            quantity = (quantity + tmp[j][menu[i]]) as int;
          }
          total.add(TotalMenuQuantity(
            name: menu[i],
            quantity: quantity,
            menuQuantity: tmpMap,
          ));
        }
      },
    );
  } catch (e) {
    print(e);
  }

  return total;
}

void deleteRoom(UserConnect user) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  await _firestore
      .collection('group')
      .where('groupId', isEqualTo: user.groupId)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      _firestore.collection('group').doc(value.docs.first.id).delete();
    }
  });
}

void joinRoom(String groupId, userId, user, context) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  await _firestore
      .collection('group')
      .where('groupId', isEqualTo: groupId)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      List<dynamic> menu = value.docs.first.data()['menuQuantity'];
      menu.add(user.menuQuantity);
      _firestore.collection('group').doc(value.docs.first.id).update({
        'users': FieldValue.arrayUnion([userId]),
        'menuQuantity': menu
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ItemChooser(user: user)),
      );
      return true;
    } else {
      return false;
    }
  });
}

void leaveRoom(UserConnect user) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  await _firestore
      .collection('group')
      .where('groupId', isEqualTo: user.groupId)
      .get()
      .then((value) async {
    if (value.docs.isNotEmpty) {
      // Update menuQuantity and users lits
      List<dynamic> users = value.docs.first.data()['users'];
      /*List<dynamic> menuQuantity = value.docs.first.data()['menuQuantity'];
      menuQuantity.removeAt(users.indexOf(user.name));
      _firestore.collection('group').doc(value.docs.first.id).update({
        'users': FieldValue.arrayRemove([user.name]),
        'menuQuantity': menuQuantity
      });*/

      // Delete collection from firebase if no user
      if (users.length == 1) {
        _firestore.collection('group').doc(value.docs.first.id).delete();
      }
    }

    await _auth.signOut();
  });
}

Future getItem() async {
  final String response = await rootBundle.loadString('assets/metadata.json');
  final data = await json.decode(response);
  return data;
}

Map<String, int> getMenuQuantity() {
  Map<String, int> menuQuantity = {};
  var items = getItem();
  items.then((value) {
    for (var i = 0; i < value['menu'].length; i++) {
      menuQuantity[value['menu'][i]['name']] = 0;
    }
  });

  return menuQuantity;
}

createGroup(String groupId, userId) async {
  List<String> members = [];
  members.add(userId);
  var items = await getItem();
  List<dynamic> tmp = items["menu"];
  List<String> menu = [];
  List<Map<String, int>> menuQuantity = [{}];

  for (var i = 0; i < tmp.length; i++) {
    menu.add(tmp[i]["name"]);
    menuQuantity[0][tmp[i]["name"]] = 0;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  _firestore
      .collection('group')
      .add({
        'groupId': groupId,
        'users': members,
        'menu': menu,
        'menuQuantity': menuQuantity
      })
      .then((value) => null)
      .catchError((error) => print(error));
}

class UserConnect {
  String groupId;
  String name;
  Map<String, int> menuQuantity = getMenuQuantity();
  UserConnect({
    required this.groupId,
    required this.name,
  });
}

class TotalMenuQuantity {
  String name;
  int quantity;
  Map<String, int> menuQuantity;

  TotalMenuQuantity({
    required this.name,
    required this.quantity,
    required this.menuQuantity,
  });
}
