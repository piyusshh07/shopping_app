import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controllers/home_controller.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      GetBuilder<HomeController>(builder: (ctrl) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('My Orders'),
            ),
            body: ListView.builder(
                itemCount: ctrl.orders.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: (
                        Card(
                          child:
                          Row(
                              children: [
                                Container(
                                  height: 70,
                                  width: 70,
                                  child: Image.network(ctrl.orders[index].BoughtProductImage ?? ""),
                                ),
                                const SizedBox(width: 20,),
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ctrl.orders[index].BoughtProductName ?? '', style: const TextStyle(
                                        fontWeight: FontWeight.bold),),
                                    Text((ctrl.orders[index].ProductPrice ?? 00).toString()),
                                    Text(ctrl.orders[index].Datetime ?? " no")
                                  ],
                                )
                              ]

                          ),
                        )
                    ),
                  );
                }

            )
        );
      })
    ;
  }
}