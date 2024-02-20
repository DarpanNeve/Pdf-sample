import 'package:flutter/material.dart';
import"package:cloud_firestore/cloud_firestore.dart";
uploadFirestore(){
for(int i=0;i<10;i++){
  FirebaseFirestore.instance.collection("data").add({
    "name":"name $i",
    "marks":i*10
  });
}

}