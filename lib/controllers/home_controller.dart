import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shopping_app/models/Orders/Orders.dart';
import 'package:shopping_app/models/productcategory/productcategory.dart';
import 'package:shopping_app/product/product.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference  categoryCollection;
  late CollectionReference orderscollection;
  String brandname='';
  List<Product> products = [];
  List<Product> productshowinUI = [];
  List<Orders> orders=[];
  List<Productcategory> productcategory=[];

  @override
  void onInit() async {
    productCollection = firestore.collection('products');
    categoryCollection = firestore.collection('category');
    orderscollection =firestore.collection('orders');
    await fetchcategory();
    await fetchproducts();
    await fetchorders();
    super.onInit();
  }

  fetchproducts() async {
    try {
      QuerySnapshot productssnapshots = await productCollection.get();
      final List<Product> retrieveproducts = productssnapshots
          .docs.map((doc) =>
          Product.fromJson(
              doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrieveproducts);
      productshowinUI.assignAll(products);
    }
    catch (error) {
      Get.snackbar('Error', error.toString(), colorText: Colors.red);
    }
    finally {
      update();
    }
  }
  fetchorders() async {
    try {
      GetStorage box = GetStorage();
      var mob = box.read('Number');

      // Debugging: Print the stored mobile number
      print('Stored mobile number: $mob');

      if (mob != null) {
        QuerySnapshot orderssnapshots = await orderscollection
            .where('MobileNo', isEqualTo: mob)
            .get();

        final List<Orders> retrieveorders = orderssnapshots.docs
            .map((doc) => Orders.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        orders.clear();
        orders.assignAll(retrieveorders);

        // Debugging: Print the retrieved orders
        print('Retrieved orders: $orders');
      } else {
        Get.snackbar('Error', 'Mobile number is not available in storage.', colorText: Colors.red);
      }
    } catch (error) {
      Get.snackbar('Error', error.toString(), colorText: Colors.red);
    } finally {
      update();
    }
  }

  fetchcategory() async {
    try {
      QuerySnapshot categorysnapshots = await categoryCollection.get();
      print('Fetched categories: ${categorysnapshots.docs.length}');

      final List<Productcategory> retrievecategory = categorysnapshots.docs
          .map((doc) {
        print('Category data: ${doc.data()}');
        return Productcategory.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      productcategory.clear();
      productcategory.assignAll(retrievecategory);
      print('Assigned categories: $productcategory');
    }
    catch (error) {
      print('Error fetching categories: $error');
      Get.snackbar('Error', error.toString(), colorText: Colors.red);
    }
  }
  filterbycategory(String Category){
    productshowinUI.clear();
    productshowinUI=products.where((product)=>product.Category==Category).toList();
    update();
  }
 filterByBrand(List<String> selectedBrands) {
    if (selectedBrands.isEmpty) {
      productshowinUI = products;
    } else {
      productshowinUI = products.where((product) => selectedBrands.contains(product.Brand)).toList();
    }
    update();
  }
  sortbyprice({required bool ascending}){
    List<Product> sortedlist=List<Product>.from(productshowinUI);
    sortedlist.sort((a,b)=> ascending ? a.Price!.compareTo(b.Price!) : b.Price!.compareTo(a.Price!));
    productshowinUI=sortedlist;
    update();
  }




}
