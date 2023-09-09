//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//design

var kMyTextStyle = GoogleFonts.orbitron(
    fontSize: 26, color: const Color.fromRGBO(80, 159, 212, 1));
var kMybodyTextStyleLarge = GoogleFonts.orbitron(
    fontSize: 24, color: const Color.fromRGBO(80, 159, 212, 1));
var kMybodyTextStyleMedium = GoogleFonts.orbitron(
    fontSize: 20, color: const Color.fromRGBO(80, 159, 212, 1));
var kMyDescriptionTextStyleMedium =
    GoogleFonts.orbitron(fontSize: 20, color: Colors.grey.shade400);
var kMybodyTextStyleSmall = GoogleFonts.orbitron(
    fontSize: 14, color: const Color.fromRGBO(80, 159, 212, 1));
var kMyElevatetButtonStyle = GoogleFonts.orbitron(
    fontSize: 18, color: const Color.fromRGBO(80, 159, 212, 1));
var kHintTextFild =
    GoogleFonts.orbitron(fontSize: 14, color: Colors.grey.shade600);
var kMyLabelFormFieldStyleMedium =
    GoogleFonts.orbitron(fontSize: 24, color: Colors.grey.shade400);
var kCarListBackground = Colors.grey.shade300;

var kSnakBarError = Colors.red.shade600;
var kSnakBarOk = Colors.green.shade600;
var kFontSizeDouble = 22.0;
var kFontSizeDoublePdfSettingsUser = 14.0;
//DropDown Styles
var kInputDecorationDropDownMenue = InputDecoration(
  //prefixIcon: Icon(Icons.date_range),
  hintText: 'Cars'.toUpperCase(),
  contentPadding: const EdgeInsets.all(10),
  hintStyle: TextStyle(letterSpacing: 2, fontSize: kFontSizeDouble),
  filled: true,
  fillColor: Colors.grey.shade600,
  errorStyle: const TextStyle(color: Colors.yellow),
);
