import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shopping_app/Screens/loginpage.dart';
import 'package:shopping_app/Widgets/otptextfield.dart';
import 'package:shopping_app/controllers/logincontroller.dart';


class Registerpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Logincontroller>(builder: (ctrl) {
      return Scaffold(body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Welcome to App", style: TextStyle(
              color: Colors.indigoAccent,
              fontSize: 30,
              fontWeight: FontWeight.bold),),
          SizedBox(height: 10,)
          , Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: ctrl.registerNamectrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  labelText: 'Enter your Name',
                  prefixIcon: Icon(Icons.phone_android)
              ),
            ),
          )
          , Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: ctrl.registerNumberctrl,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  labelText: 'Mobile Number',
                  prefixIcon: Icon(Icons.phone_android)

              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 10,),
          Otptextfield(
            otpController: ctrl.otpController,
            visible:ctrl.otpfieldshown,
            onComplete: (otp){
              ctrl.otpentered =int.tryParse(otp!) ;},),
          ElevatedButton(onPressed: () {
            if(ctrl.otpfieldshown){
              ctrl.addUser();
            }else{
            ctrl.sendotp();
            }
          }, child: Text(ctrl.otpfieldshown==true ? "Register": 'Send OTP')),
          TextButton(onPressed: (){
           Navigator.pop(context);
          },
              child: Text(
                'Login to the app', style: TextStyle(color: Colors.black),)),
        ],
      ),);
    })
    ;
  }
}