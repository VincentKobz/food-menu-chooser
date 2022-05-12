import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void joinRoom(String groupId, userId) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  await _firestore
      .collection('group')
      .where('groupId', isEqualTo: groupId)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      _firestore.collection('group').doc(value.docs.first.id).update({
        'users': FieldValue.arrayUnion([userId])
      });
      return true;
    } else {
      return false;
    }
  });
}

void leaveRoom(String groupId) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  await _firestore
      .collection('group')
      .where('groupId', isEqualTo: groupId)
      .get()
      .then((value) {
    if (value.docs.isNotEmpty) {
      _firestore.collection('group').doc(value.docs.first.id).update({
        'users': FieldValue.arrayRemove([_auth.currentUser?.uid])
      });
      return true;
    } else {
      return false;
    }
  });
}

class DataBase {
  createGroup(String groupId, userId) {
    List<String> members = [];
    members.add(userId);

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    _firestore
        .collection('group')
        .add({'groupId': groupId, 'users': members})
        .then((value) => null)
        .catchError((error) => print(error));
  }
}
