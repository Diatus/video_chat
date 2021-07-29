

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reach/services/auth.dart';

class DataBase{
  final db=Firestore.instance;


  Stream<DocumentSnapshot>profile(){

    return db.collection('Users').document(UserServices.uid).snapshots();
  }

  Stream<QuerySnapshot>celebrity(){
    return db.collection('Celebrity').snapshots();
  }

  Stream<QuerySnapshot>featured(){
    return db.collection('Celebrity').where('promote',isEqualTo: true).snapshots();
  }

  Stream<QuerySnapshot>hollywood(String filter,String sort){
    if(filter!=null&&filter.isNotEmpty){
      if(sort!=null&&sort.isNotEmpty&&sort.length>2){
        return db.collection('Celebrity').where('filter',isEqualTo: filter).orderBy(sort,descending: true).limit(10).snapshots();
      }
      return db.collection('Celebrity').where('filter',isEqualTo: filter).limit(10).snapshots();
    }
    return db.collection('Celebrity').limit(10).snapshots();
  }

  Stream<QuerySnapshot>notifications(){
    return db.collection('Notifications').where('user',isEqualTo: UserServices.uid).orderBy('time',descending: true).snapshots();
  }

  Stream<QuerySnapshot>unreadNotification(){
    return db.collection('Notifications').where('user',isEqualTo: UserServices.uid).where('status',isEqualTo: false).snapshots();
  }

  Stream<QuerySnapshot>bookings(){
    return db.collection('Bookings').where('user',isEqualTo: UserServices.uid).orderBy('bookedon',descending: true).snapshots();
  }

  Stream<QuerySnapshot>bookingSort(String sort){
    return db.collection('Bookings').where('user',isEqualTo: UserServices.uid).where('status',isEqualTo: sort).orderBy('bookedon',descending: true).snapshots();
  }

  Stream<DocumentSnapshot>bookingStatus(String doc){
    return db.collection('Bookings').document(doc).snapshots();
  }

  Stream<QuerySnapshot>liveStream(String sort){
    if(sort!=null&&sort.isNotEmpty){
      return db.collection('Live').where('category',isEqualTo: sort).orderBy('time',descending: true).snapshots();
    }
    return db.collection('Live').orderBy('time',descending: true).snapshots();
  }

  Stream<DocumentSnapshot>liveStatus(String doc){
    return db.collection('Live').document(doc).snapshots();
  }

  Stream<QuerySnapshot>payments(){
    return db.collection('Payments').where('user',isEqualTo: UserServices.uid).orderBy('time',descending: true).snapshots();
  }
}

DataBase dataBase=new DataBase();