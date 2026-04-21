import 'package:desktop_file_picker/src/presentation/components/content_grid/drive_content_grid.dart';
import 'package:flutter/material.dart';

import '../../../desktop_file_picker_viewmodel.dart';
import 'disk_content_grid.dart';

class ContentGrid extends StatelessWidget {
  final DesktopFilePickerViewModel model;

  const ContentGrid({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: model.isMountPointSelected,
      replacement: DiskContentGrid(model: model),
      child: DriveContentGrid(model: model),
    );
  }
}
