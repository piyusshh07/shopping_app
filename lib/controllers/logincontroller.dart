import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';
import 'package:shopping_app/Screens/homepage.dart';
import 'package:shopping_app/models/user/user.dart';

class Logincontroller extends GetxController {
  GetStorage box =GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;
  TextEditingController registerNamectrl = TextEditingController();
  TextEditingController registerNumberctrl = TextEditingController();
  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  TextEditingController MobileNumberCtrl = TextEditingController();
  bool otpfieldshown = false;
  int? otpsent;
  int? otpentered;
  bool loading = false;
  User? Loggeduser;

  @override
  void onInit() {
    userCollection = firestore.collection('Users');
    super.onInit();
  }

  @override
  void onReady() {
    Map<String , dynamic> user=box.read("Loginuser");
    if(user!=null){
      Loggeduser=User.fromJson(user);
      Get.to(Homepage());
    }
    super.onReady();
  }

  addUser() {
    try {
      loading = true;
      update();
      if (registerNamectrl.text.isEmpty || registerNumberctrl.text.isEmpty) {
        Get.snackbar("Error", 'Please enter the details',
            colorText: Colors.red);
        return;
      }
      // if(otpsent==otpentered){ //otp verification
      DocumentReference doc = userCollection.doc();

      User user = User(
        id: doc.id,
        Name: registerNamectrl.text,
        MobileNo: int.parse(registerNumberctrl.text),
      );
      final UserJson = user.toJson();
      doc.set(UserJson);
      Get.snackbar("Success", 'User added successfully please Login',
          colorText: Colors.green);
      loading = false;
      update();
      registerNumberctrl.clear();
      registerNamectrl.clear();
      //  } //otp verification
      //  else{ //otp verification
      // Get.snackbar("Failed Attempt ", 'OTP is incoreect',colorText: Colors.red);//otp verification
      // } //otp verification
    } catch (error) {
      Get.snackbar("Error", error.toString(), colorText: Colors.red);
    }
  }

  sendotp() async {
    loading = true;
    update();
    if (registerNamectrl.text.isEmpty || registerNumberctrl.text.isEmpty) {
      Get.snackbar("Error", 'Please enter the details', colorText: Colors.red);
      return;
    }
    final randomnumber = Random();
    int otp = 1000 + randomnumber.nextInt(9998);
    print(otp);

    //For otp verification
    // String url ="";    //enter the url from fast2sms with $otp and $registerNumberctrl
    //Response res= await GetConnect().get(url);
    // if(res.body['message'][0]=='SMS sent successfully.'){
    //   Get.snackbar("Success", 'OTP sent Successfully',colorText: Colors.green);
    //   }else{
    //   Get.snackbar("Error", 'OTP not sent! ',colorText: Colors.red);
    if (otp != null) {
      otpfieldshown = true;
      update();
      otpsent = otp;
      Get.snackbar("Success", 'OTP sent Successfully', colorText: Colors.green);
    } else {
      Get.snackbar("Error", 'OTP not sent! ', colorText: Colors.red);
    }
    loading = false;
    update();
  }

  Future<void> loginwithnumber() async {
    try {
      loading = true;
      update();
      String mobilenumber = MobileNumberCtrl.text;
      if (mobilenumber.isNotEmpty) {
        var quersnapshot = await userCollection
            .where('MobileNo', isEqualTo: int.tryParse(mobilenumber!))
            .limit(1)
            .get();
        if (quersnapshot.docs.isNotEmpty) {
          var userdoc = quersnapshot.docs.first;
          var userdata = userdoc.data() as Map<String, dynamic>;
          box.write('Loginuser', userdata);
          print(box);
          MobileNumberCtrl.clear();
          Get.snackbar('success', 'User Logged in successfully',
              colorText: Colors.green);
          Get.to(Homepage());
        } else {
          Get.snackbar("Failed Attempt", 'user not found please register',
              colorText: Colors.red);
        }
      }
      loading = false;
      update();
    } catch (error) {
      Get.snackbar("Error", error.toString(), colorText: Colors.red);
    }
  }
}
