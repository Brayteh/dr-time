import 'package:flutter/material.dart';

OutlineInputBorder myCustomBorder({Color color = Colors.black}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
    borderSide: BorderSide(color: color),
    
  );
}

