import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app/controllers/logincontroller.dart';
import 'package:shopping_app/models/Orders/Orders.dart';

class OrderController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference productCollection;
  TextEditingController addressctrl =TextEditingController();
  bool Loading=false;
  String image='';
  String id='';
  int? price;
  String productname='';

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
      DocumentReference reference=productCollection.doc();
      Orders order=Orders(
        BoughtProductName: productname,
        ProductPrice: price!.toDouble(),
        MobileNo: mobno,
        BoughtProductImage: image,
        id: id,
        UserName: user,
        Address : addressctrl.text,
      );
      final Orderjson=order.toJson();
      reference.set(Orderjson);
      Get.snackbar("Success", 'Order Places Successfully',
          colorText: Colors.green);

    }catch(error){
      Get.snackbar("Error", error.toString(),colorText: Colors.red);
    }
 }

}