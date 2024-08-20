import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app/Screens/loginpage.dart';
import 'package:shopping_app/Screens/orders_screen.dart';
import 'package:shopping_app/Screens/productdescription.dart';
import 'package:shopping_app/Widgets/dropdown_multi.dart';
import 'package:shopping_app/Widgets/dropdownbtn.dart';
import 'package:shopping_app/Widgets/productcard.dart';
import 'package:shopping_app/controllers/home_controller.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      GetStorage box = GetStorage();
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchproducts();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Products'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(OrdersScreen());
                    ctrl.fetchorders();
                  },
                  icon: Icon(Icons.shopping_bag)),
        PopupMenuButton(
          itemBuilder: (ctx) => [
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(Icons.login),
                  SizedBox(width: 20),
                  Container(width: 100, child: Text('Logout')),
                ],
              ),
              onTap: () {
                box.erase();
                Get.offAll(Loginpage());
              },
            )
            ],
          )
      ]
          ),
          body: Column(
            children: [
              Container(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.productcategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.filterbycategory(
                              ctrl.productcategory[index].Name ?? '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Chip(
                              label: Text(
                                  ctrl.productcategory[index].Name ?? "Error")),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Container(
                        height: 50,
                        child: DropdownMulti(),
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing between the Dropdowns
                    Flexible(
                      child: Container(
                        height: 50,
                        child: Dropdownbtn(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 8),
                  padding: EdgeInsets.all(5),
                  itemCount: ctrl.productshowinUI.length,
                  itemBuilder: (ctx, index) {
                    return Productcard(
                      Name:
                          ctrl.productshowinUI[index].ProductName ?? 'No name',
                      Price: ctrl.productshowinUI[index].Price ?? 0,
                      Imageurl: ctrl.productshowinUI[index].ImageUrl ??
                          'image not available',
                      offer: '20% off',
                      onTap: () {
                        Get.to(Productdescription(), arguments: {
                          'data': ctrl.productshowinUI[index],
                        });
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
