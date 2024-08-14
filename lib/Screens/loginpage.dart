import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shopping_app/Screens/registerpage.dart';
import 'package:shopping_app/controllers/logincontroller.dart';

class Loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Logincontroller>(builder: (ctrl) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome Back", style: TextStyle(
                color: Colors.indigoAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold),),
            SizedBox(height: 10,)
            , Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: ctrl.MobileNumberCtrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Mobile Number',
                    prefixIcon: Icon(Icons.phone_android)
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  ctrl.loginwithnumber();
                }, child: ctrl.loading ? CircularProgressIndicator(color: Colors.white,): Text("Login")),
            TextButton(onPressed: () {
              Get.to(Registerpage(),transition: Transition.cupertino);
            },
                child: Text('Register a new user..!',
                  style: TextStyle(color: Colors.black),)),
          ],
        ),
      );
    });
  }
  }