import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/controllers/home_controller.dart';

class DropdownMulti extends StatefulWidget {
  @override
  State<DropdownMulti> createState() {
    return _dropDownMultiState();
  }
}

class _dropDownMultiState extends State<DropdownMulti> {
  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Nike',
      'Adidas',
      'Puma',
      'RedTape',
      'Skechers',
      'Reebok'
    ];
    List<String> selectedItems = [];
    return
      GetBuilder<HomeController>(builder: (ctrl) {
        return DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            borderRadius: BorderRadius.circular(20),
            hint: const Text(
              'Select Brand',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black
              ),
            ),
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                //disable default onTap to avoid closing menu when selecting an item
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = selectedItems.contains(item);
                    return InkWell(
                      onTap: () {
                        isSelected ? selectedItems.remove(item) : selectedItems
                            .add(item);

                        //This rebuilds the StatefulWidget to update the button's text
                        setState(() {});
                        print(selectedItems);

                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                        ctrl.filterByBrand(selectedItems);
                        ctrl.update();
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            if (isSelected)
                              const Icon(Icons.check_box_outlined)
                            else
                              const Icon(Icons.check_box_outline_blank),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
            //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
            value: selectedItems.isEmpty ? null : selectedItems.last,
            onChanged: (value) {},
            selectedItemBuilder: (context) {
              return items.map(
                    (item) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      selectedItems.join(', '),
                      style: const TextStyle(
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                  );
                },
              ).toList();
            },

          ),
        );
      });
  }
}