import 'dart:developer';

import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({super.key, required this.selectId, required this.dataList, required this.hint});
  String? selectId;
  List<Map<String, String>> dataList;
  String hint;

  @override
  State<StatefulWidget> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.3),
          borderRadius: const BorderRadius.all(Radius.circular(2))),
      padding: const EdgeInsets.only(left: 5),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          iconEnabledColor: Colors.grey[300],
          // iconDisabledColor: Colors.white,
          dropdownColor: Colors.grey[100],
          isExpanded: true,
          value: widget.selectId,
          items: widget.dataList.map((item) {
            return DropdownMenuItem(
              value: item['id'],
              child: Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.w400)),
            );
          }).toList(),
          onChanged: (value) {
            widget.selectId = value!;
            log('Selected Id : ${widget.selectId}');
            setState(() {});
          },
          hint: Text(widget.hint),
        ),
      ),
    );
  }

}