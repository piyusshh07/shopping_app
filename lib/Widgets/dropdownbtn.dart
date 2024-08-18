import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shopping_app/controllers/home_controller.dart';
class Dropdownbtn extends StatelessWidget {
  Dropdownbtn({super.key});

  @override
  Widget build(BuildContext context) {
    var _selectedBrand;
    return GetBuilder<HomeController>(builder: (ctrl) {
      return DropdownButtonHideUnderline(
        child: Expanded( // or Flexible
          child: DropdownButton<String>(
            icon: Icon(Icons.arrow_drop_down),
            value: _selectedBrand,
            borderRadius: BorderRadius.circular(20),
            padding: EdgeInsets.only(left: 5, right: 5),
            hint: const Text(
              'Sort',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            onChanged: (newValue) {
              print(newValue);
              ctrl.sortbyprice(ascending: newValue=='ascending' ? true : false);
              // Update your state logic here
            },
            items: const [
              DropdownMenuItem<String>(
                  value: 'ascending', child: Text('Price Low to High')),
              DropdownMenuItem<String>(
                  value: 'descending', child: Text('Price High to Low')),
            ],
          ),
        ),
      );
    });
  }
}
