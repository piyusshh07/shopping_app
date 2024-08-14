import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Productdescription extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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
                   'https://assets.adidas.com/images/h_2000,f_auto,q_auto,fl_lossy,c_fill,g_auto/088e65d985b644deacda44e6944a54ac_9366/YEEZY_BOOST_350_V2_White_ID4811_01_standard1_hover.jpg',
                   fit: BoxFit.cover,
                   width: double.infinity,
                 )),
             SizedBox(height: 10,),
             Text('Adidas',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
             SizedBox(height: 10,),
             Text('Rs : 2000',style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),
             SizedBox(height: 10,),
             Text(
               'The disruptions of World War II presented challenges for Adidas, as Adi and his brother Rudolf worked to rebuild the Dassler firm. By 1948, a personal rift between the brothers became irreparable, leading to a split in the business. Rudi’s company eventually became Puma, while Adi’s venture retained the name Adidas.',
               style: TextStyle(fontSize: 10,color: Colors.black),
             maxLines: 10,),
             SizedBox(height: 10,),
             TextField(
               maxLines: 6,
               decoration: InputDecoration(
                 label: Text('Enter billing address'),
                 border: OutlineInputBorder(
                 )
               )
             ),
             Center(child: ElevatedButton(onPressed: (){}, child: Text('Proceed to Buy',style: TextStyle(fontSize: 15),)))
           ],
         ),
       ),
     ),
   );
  }
}