import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app/controllers/Order_controller.dart';
import 'package:shopping_app/controllers/home_controller.dart';
import 'package:shopping_app/product/product.dart';

class Productdescription extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments['data'];
    return GetBuilder<OrderController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      product.ImageUrl ?? ''
                      ,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )),
                const SizedBox(height: 10,),
                Text(product.ProductName ?? '', style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text('Rs. ${product.Price ?? ''}', style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Text(
                  product.Description ?? '',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  maxLines: 10,),
                SizedBox(height: 10,),
                 TextField(
                    controller:ctrl.addressctrl,
                    maxLines: 6,
                    decoration: const InputDecoration(
                        hintText: 'Enter Billing Address',
                        border: OutlineInputBorder(
                        )
                    )
                ),
                Center(child: ElevatedButton(onPressed: () {
                  ctrl.price = product.Price?.toInt();
                  ctrl.productname=product.ProductName ?? "No name";
                  ctrl.image=product.ImageUrl ?? 'No image';
                  ctrl.id=product.id!;
                  ctrl.buyProduct();
                },
                    child: const Text(
                      'Buy Now', style: TextStyle(fontSize: 15),)))
              ],
            ),
          ),
        ),
      );
    });
  }
}