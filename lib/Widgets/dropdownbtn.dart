import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dropdownbtn extends StatefulWidget{
  Dropdownbtn({super.key});
  @override
  State<Dropdownbtn> createState() {
  return _dropdownbtnState();
  }

}
class _dropdownbtnState extends State<Dropdownbtn>{
   var _selectedBrand;
  @override
  Widget build(BuildContext context) {
   return DropdownButtonHideUnderline(
     child: DropdownButton<String>(
       icon: Icon(Icons.arrow_drop_down),
       value: _selectedBrand,

       borderRadius: BorderRadius.circular(20),
       padding: EdgeInsets.only(left: 5, right: 5),
       hint: Text('Select Brand',style: TextStyle(fontSize: 16,color: Colors.black),),
       onChanged: (newValue) {
         setState(() {
           _selectedBrand = newValue!;
         });
       },
       items: [
         DropdownMenuItem<String>(
             value: 'Nike', child: Text('Nike',)),
         DropdownMenuItem<String>(
             value: 'Adidas', child: Text('Adidas')),
         DropdownMenuItem<String>(
             value: 'Puma', child: Text('Puma')),
         DropdownMenuItem<String>(
             value: 'RedTape', child: Text('RedTape')),
         DropdownMenuItem<String>(
             value: 'Skechers', child: Text('Skechers')),
         DropdownMenuItem<String>(
             value: 'Reebok', child: Text('Reebok')),
       ],
     ),
   );
  }
}