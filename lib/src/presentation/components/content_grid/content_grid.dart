import 'package:desktop_file_picker/src/presentation/components/content_grid/drive_content_grid.dart';
import 'package:flutter/material.dart';

import '../../../desktop_file_picker_viewmodel.dart';
import 'disk_content_grid.dart';

// ignore: must_be_immutable
class ContentGrid extends StatelessWidget {
  late DesktopFilePickerViewModel model;

  ContentGrid({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: model.isMountPointSelected,
      replacement: Expanded(
        flex: 2,
        child: DiskContentGrid(model: model),
      ),
      child: Expanded(
        flex: 2,
        child: DriveContentGrid(model: model),
      ),
    );
  }
}
