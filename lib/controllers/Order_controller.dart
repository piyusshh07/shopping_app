import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app/controllers/logincontroller.dart';
import 'package:shopping_app/models/Orders/Orders.dart';
import 'package:intl/intl.dart';

class OrderController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference productCollection;
  TextEditingController addressctrl =TextEditingController();
  bool Loading=false;
  String image='';
  String id='';
  int? price;
  String productname='';
  String currentdate=DateFormat('d MMM y').format(DateTime.now());

  @override
  void onInit() {
    productCollection=firestore.collection('orders');
    super.onInit();
  }
 buyProduct(){
    if(addressctrl.text.isEmpty){
      Get.snackbar("Error", "Enter billing address first",colorText: Colors.red);
      return;
    }
    GetStorage box = GetStorage();
    var user=box.read('User');
    var mobno=box.read('Number');

    try{
      Loading=true;
      update();
      DocumentReference reference=productCollection.doc();
      Orders order=Orders(
        BoughtProductName: productname,
        ProductPrice: price!.toDouble(),
        MobileNo: mobno,
        BoughtProductImage: image,
        id: id,
        UserName: user,
        Address : addressctrl.text,
        Datetime: currentdate,
      );
      final Orderjson=order.toJson();
      reference.set(Orderjson);
      Get.snackbar("Success", 'Order Placed Successfully',
          colorText: Colors.green);
      addressctrl.clear();

    }catch(error){
      Get.snackbar("Error", error.toString(),colorText: Colors.red);
    }
    Loading=false;
    update();
 }

}