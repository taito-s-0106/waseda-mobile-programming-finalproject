import 'package:flutter/material.dart';

class DropdownButtonMenu extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const DropdownButtonMenu({Key? key,required this.onChanged}):super(key:key);

  @override
  State<DropdownButtonMenu> createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButtonMenu> {
   String selectedValue = "食費";

  @override
  Widget build(BuildContext context){
    return DropdownButton(
      items: const[
        DropdownMenuItem(
          value:  "食費",
          child: Text("食費"),
          ),
          DropdownMenuItem(
          value:  "光熱費",
          child: Text("光熱費"),
          ),
          DropdownMenuItem(
          value:  "日用品",
          child: Text("日用品"),
          ),
          DropdownMenuItem(
          value:  "その他",
          child: Text("その他"),
          ),
      ],
      value: selectedValue,
     onChanged: (String? value){
      setState((){
        selectedValue = value!;
      });
      if(widget.onChanged != null)
      {
        widget.onChanged!(selectedValue);
      }
     },
     );
  }
  }