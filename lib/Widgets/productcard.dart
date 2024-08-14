import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Productcard extends StatelessWidget{
  Productcard({super.key,required this.Name, required this.Price, required this.Imageurl, required this.offer, required this.onTap});
  final String Name;
  final double Price;
  final String Imageurl;
  final String offer;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                 Imageurl,
                  fit: BoxFit.cover,
                width: double.maxFinite,
                height: 120,),
                SizedBox(height: 8),
                Text(Name,style: TextStyle(color: Colors.black),overflow: TextOverflow.fade),
                SizedBox(height: 8),
                Text('Rs.$Price',style: TextStyle(color: Colors.black),overflow: TextOverflow.fade),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(2),
                    color: Colors.green
                    ,child: Text(offer,style: TextStyle(color: Colors.white,fontSize: 10),overflow: TextOverflow.fade))
              ],
            ),
          ),
      ),
    );
  }
}