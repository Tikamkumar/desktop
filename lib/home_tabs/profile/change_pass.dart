import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
   const ChangePassword({super.key});

  @override
  State<StatefulWidget> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePassword> {
  TextEditingController currPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         padding: EdgeInsets.all(12),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Text('CHANGE PASSWORD', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500)),
             SizedBox(height: 20),
             Row(
               children: <Widget>[
                 Text('Current Password ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                 SizedBox(width: 10),
                 Container(
                   height: 35,
                   width: 300,
                   padding: EdgeInsets.symmetric(horizontal: 5),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     border: Border.all(color: Colors.grey[300]!, width: 1)
                   ),
                   child: TextField(
                     controller: currPassController,
                     textAlignVertical: TextAlignVertical.center,
                     decoration: InputDecoration(
                       contentPadding: EdgeInsets.zero,
                       isDense: true,
                       border: InputBorder.none
                     ),
                   ),
                 )
               ],
             ),
             SizedBox(height: 10),
             Row(
               children: <Widget>[
                 Text('Create Password   ', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                 SizedBox(width: 10),
                 Container(
                   height: 35,
                   width: 300,
                   padding: EdgeInsets.symmetric(horizontal: 5),
                   decoration: BoxDecoration(
                       color: Colors.white,
                       border: Border.all(color: Colors.grey[300]!, width: 1)
                   ),
                   child: TextField(
                     controller: newPassController,
                     textAlignVertical: TextAlignVertical.center,
                     decoration: InputDecoration(
                         contentPadding: EdgeInsets.zero,
                         isDense: true,
                         border: InputBorder.none
                     ),
                   ),
                 )
               ],
             ),
             SizedBox(height: 10),
             Row(
               children: <Widget>[
                 Text('Confirm Password', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
                 SizedBox(width: 10),
                 Container(
                   height: 35,
                   width: 300,
                   padding: EdgeInsets.symmetric(horizontal: 5),
                   decoration: BoxDecoration(
                       color: Colors.white,
                       border: Border.all(color: Colors.grey[300]!, width: 1)
                   ),
                   child: TextField(
                     controller: confirmPassController,
                     textAlignVertical: TextAlignVertical.center,
                     decoration: InputDecoration(
                         contentPadding: EdgeInsets.zero,
                         isDense: true,
                         border: InputBorder.none
                     ),
                   ),
                 )
               ],
             ),
             SizedBox(height: 20),
             Row(
               mainAxisSize: MainAxisSize.min,
               children: [
                 Container(
                   padding: EdgeInsets.all(8),
                   decoration: BoxDecoration(
                       color: Colors.brown,
                       border: Border.all(color: Colors.white, width: 5)
                   ),
                   child: const Center(
                     child: Text('Update Password', style: TextStyle(color: Colors.white),)
                   )
                 ),
               ],
             ),
           ],
         ),
       ),
     );
  }

}