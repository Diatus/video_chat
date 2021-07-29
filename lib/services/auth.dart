import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';


class UserServices{

  static String uid;
  static double wallet=0.0;
  FirebaseAuth auth=FirebaseAuth.instance;
  CollectionReference userCollection=Firestore.instance.collection('Users');
  Future<String>user()async{
    FirebaseAuth auth=FirebaseAuth.instance;
    auth.onAuthStateChanged.listen((event) {
      if(event!=null){
        uid=event.uid;
      }
    });
  }

  Future notification(String token)async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    CollectionReference userCollection=Firestore.instance.collection('Users');
    try{
      userCollection.document(user.uid).setData({
        'token':token
      },merge: true);
    }catch(e){

    }
  }

  Future<dynamic> getUserProfile()async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    if(user!=null){
      try{
        DocumentSnapshot ds=await userCollection.document(user.uid).get();
        return  ds.data;
      }on PlatformException catch(e){
        throw e;
      }
    }
  }

  Future<dynamic> getWallet()async{
    FirebaseUser user=await FirebaseAuth.instance.currentUser();
    if(user!=null){
      try{
        await userCollection.document(user.uid).get().then((value){
          if(value.exists&&value.data['wallet']!=null){
            wallet=value.data['wallet'];
          }
        });
      }on PlatformException catch(e){
        throw e;
      }
    }
  }
}

UserServices userServices=new UserServices();
