import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/Screens/productdescription.dart';
import 'package:shopping_app/Widgets/dropdown_multi.dart';
import 'package:shopping_app/Widgets/dropdownbtn.dart';
import 'package:shopping_app/Widgets/productcard.dart';

class Homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Products'),
       centerTitle: true,
     ),
     body: Column(
       children: [
         Container(
           height: 50,
           child: ListView.builder(
             scrollDirection: Axis.horizontal,
               itemCount: 5,
               itemBuilder: (ctx,index){
               return
               Padding(
                 padding: const EdgeInsets.all(6),
                 child: Chip(label: Text('Category')),
               );
               }),
         ),
         Padding(
           padding: const EdgeInsets.only(left: 10,right: 10),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
                Container(
                  height: 50,width: 130,child: DropdownMulti(),),
               Container(
                 height: 50,width: 130,child: Dropdownbtn(),),

             ],
           ),
         ),
         Expanded(
           child: GridView.builder(
             gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 crossAxisSpacing: 8,
                 childAspectRatio: 0.8,
                 mainAxisSpacing:8 ),
             padding: EdgeInsets.all(5),
             itemBuilder: (ctx,index){
              return Productcard(
                  Name: 'Adidas',
                  Price: 100,
                  Imageurl: 'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/088e65d985b644deacda44e6944a54ac_9366/YEEZY_BOOST_350_V2_White_ID4811_01_standard1_hover.jpg',
                  offer: '20% off',
              onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Productdescription()));
              },);
             },),
         )
       ],
     ),
   );
  }
}