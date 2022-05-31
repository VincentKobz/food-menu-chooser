import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sushi/components/alert.dart';
import 'package:sushi/screens/menu_chooser.dart';

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
      List<dynamic> users = value.docs.first.data()['users'];

      for (var i = 0; i < users.length; i++) {
        if (users[i] == user.name) {
          showAlertDialogDuplicateUser(context);
          return null;
        }
      }

      menu.add(user.menuQuantity);
      _firestore.collection('group').doc(value.docs.first.id).update({
        'users': FieldValue.arrayUnion([userId]),
        'menuQuantity': menu
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ItemChooser(user: user)),
      );
    } else {
      showAlertDialogGroupID(context);
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
  var items = await getItem();
  List<dynamic> tmp = items["menu"];
  List<String> menu = [];
  Map<String, int> menuQuantity = {};

  for (var i = 0; i < tmp.length; i++) {
    menu.add(tmp[i]["name"]);
    menuQuantity[tmp[i]["name"]] = 0;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  _firestore.collection('group').doc(groupId).set({
    'menu': menu,
  });

  _firestore
      .collection('group')
      .doc(groupId)
      .collection("users")
      .doc(userId)
      .set({'menuQuantity': menuQuantity});
}

Future<List<TotalMenuQuantity>> getTotalQuantity(UserConnect user) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<TotalMenuQuantity> total = [];

  try {
    await _firestore
        .collection('group')
        .doc(user.groupId)
        .get()
        .then((value) async {
      final String response =
          await rootBundle.loadString('assets/metadata.json');
      final data = await json.decode(response);
      List item = data['menu'];
      List sort = data['total_sort'];

      for (int i = 0; i < item.length; i++) {
        var index = item.indexWhere((element) => element['name'] == sort[i]);
        total.add(TotalMenuQuantity(
            description: item[index]['description'],
            name: item[index]['name'],
            quantity: 0,
            menuQuantity: {}));
      }
    });

    await _firestore
        .collection('group')
        .doc(user.groupId)
        .collection("users")
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        Map<dynamic, dynamic> tmp = value.docs[i].data()['menuQuantity'];
        for (int j = 0; j < total.length; j++) {
          total[j].menuQuantity[value.docs[i].id] = tmp[total[j].name] as int;
          total[j].quantity += tmp[total[j].name] as int;
        }
      }
    });
  } catch (e) {
    deleteRoom(user);
  }
  return total;
}

Future<void> updateMenuQuantity(UserConnect user, int count, int index) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var key = user.menuQuantity.keys.elementAt(index);
  user.menuQuantity[key] = count + user.menuQuantity[key]!;

  // check if negative
  if (user.menuQuantity[key]! < 0) {
    user.menuQuantity[key] = 0;
  }

  _firestore
      .collection('group')
      .doc(user.groupId)
      .collection("users")
      .doc(user.name)
      .update({'menuQuantity': user.menuQuantity});
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
  String description;
  int quantity;
  Map<String, int> menuQuantity;

  TotalMenuQuantity({
    required this.description,
    required this.name,
    required this.quantity,
    required this.menuQuantity,
  });
}
