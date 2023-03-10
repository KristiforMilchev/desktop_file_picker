import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectBinding extends Equatable {
  late String name;
  late String extension;
  late String path;
  late DateTime? modifiedDate;
  late String size;
  late IconData icon;
  late bool isFolder;
  late bool isSelected;
  late bool isVisible;

  SelectBinding({
    required this.name,
    required this.extension,
    required this.path,
    this.modifiedDate,
    required this.size,
    required this.icon,
    required this.isFolder,
    required this.isSelected,
    required this.isVisible,
  });

  @override
  List<Object?> get props => [name, path, extension, modifiedDate];
}
