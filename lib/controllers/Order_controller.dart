import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference productCollection;
  TextEditingController addressctrl =TextEditingController();
  bool Loading=false;

  @override
  void onInit() {
    productCollection=firestore.collection('Orders');
    super.onInit();
  }
 buyProduct(){
    if(addressctrl.text.isEmpty){
      Get.snackbar("Error", "Enter billing address first",colorText: Colors.red);
      return;
    }
    try{

      
    }catch(error){
      Get.snackbar("Error", error.toString(),colorText: Colors.red);
    }
 }

}