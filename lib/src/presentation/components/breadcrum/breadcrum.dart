import 'package:flutter/material.dart';

import '../../../desktop_file_picker_viewmodel.dart';
import '../../../domain/styles.dart';

// ignore: must_be_immutable
class Breadcrum extends StatelessWidget {
  DesktopFilePickerViewModel model;

  Breadcrum({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: (p1.maxWidth - 5),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => model.themeSettings!.buttonColor),
                ),
                onPressed: (() => model.changeMountPoint()),
                icon: Icon(
                  Icons.folder_open,
                  color: model.themeSettings!.mainTextColor,
                  size: 48,
                ),
                label: Container(
                  width: (p1.maxWidth - 5),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Text(
                    model.selectedDomainFolder!.name,
                    style: TextStyle(
                        color: ThemeColors.mainText,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 48),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
