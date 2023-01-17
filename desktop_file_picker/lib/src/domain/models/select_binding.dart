import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectBinding extends Equatable {
  late String name;
  late String path;
  late String modifiedDate;
  late String size;
  late IconData icon;

  SelectBinding({
    required this.name,
    required this.path,
    required this.modifiedDate,
    required this.size,
    required this.icon,
  });

  @override
  List<Object?> get props => [name, path];
}