import 'package:flutter/material.dart';

class ResponsiveTextField extends StatelessWidget {
  const ResponsiveTextField({super.key, required this.controller, required this.hint});
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[400]!, width: 1),
        borderRadius: BorderRadius.circular(2),
        /* boxShadow: [
                                    BoxShadow(
                                        blurRadius: 3.0,
                                        spreadRadius: 1.0,
                                        offset: const Offset(1, 3),
                                        color: Colors.grey[200]!
                                    )
                                  ]*/
      ),
      child: TextField(
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
          border: InputBorder.none,
        ),
      ),
    );
  }

}