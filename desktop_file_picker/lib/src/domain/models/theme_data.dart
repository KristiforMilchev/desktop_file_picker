import 'package:flutter/material.dart';

class PickerThemeData {
  late Color? mainBackground;
  late Color? mainTextColor;
  late Color? buttonColor;
  late Color? inputColor;
  late Color? inputBorderColor;
  late Color? inputFocusColor;
  late Color? breadCrumbBackground;
  late Color? selectedItemColor;
  late IconData? imageIcon;
  late IconData? musicIcon;
  late IconData? videoIcon;
  late IconData? archiveIcon;
  late IconData? folderIcon;
  late IconData? fileIcon;

  PickerThemeData(
      {this.mainBackground,
      this.mainTextColor,
      this.inputColor,
      this.inputBorderColor,
      this.inputFocusColor,
      this.breadCrumbBackground,
      this.selectedItemColor,
      this.videoIcon,
      this.musicIcon,
      this.imageIcon,
      this.folderIcon,
      this.fileIcon,
      this.archiveIcon,
      this.buttonColor});
}
