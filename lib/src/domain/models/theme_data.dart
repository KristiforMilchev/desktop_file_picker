import 'package:flutter/material.dart';

class PickerThemeData {
  final Color? mainBackground;
  final Color? mainTextColor;
  final Color? buttonColor;
  final Color? inputColor;
  final Color? inputBorderColor;
  final Color? inputFocusColor;
  final Color? breadCrumbBackground;
  final Color? selectedItemColor;
  final IconData? imageIcon;
  final IconData? musicIcon;
  final IconData? videoIcon;
  final IconData? archiveIcon;
  final IconData? folderIcon;
  final IconData? fileIcon;

  final double? radiusSmall;
  final double? radiusMedium;
  final double? radiusLarge;

  const PickerThemeData({
    this.mainBackground,
    this.mainTextColor,
    this.buttonColor,
    this.inputColor,
    this.inputBorderColor,
    this.inputFocusColor,
    this.breadCrumbBackground,
    this.selectedItemColor,
    this.imageIcon,
    this.musicIcon,
    this.videoIcon,
    this.archiveIcon,
    this.folderIcon,
    this.fileIcon,
    this.radiusSmall,
    this.radiusMedium,
    this.radiusLarge,
  });

  double get smallRadius => radiusSmall ?? 4;
  double get mediumRadius => radiusMedium ?? 6;
  double get largeRadius => radiusLarge ?? 8;
}
