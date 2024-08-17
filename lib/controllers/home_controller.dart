import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/models/productcategory/productcategory.dart';
import 'package:shopping_app/product/product.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference  categoryCollection;
  List<Product> products = [];
  List<Product> productshowinUI = [];
  List<Productcategory> productcategory=[];

  @override
  void onInit() async {
    productCollection = firestore.collection('products');
    categoryCollection = firestore.collection('category');
    await fetchcategory();
    await fetchproducts();
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

}
