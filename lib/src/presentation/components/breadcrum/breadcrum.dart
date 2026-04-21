import 'package:flutter/material.dart';

import '../../../desktop_file_picker_viewmodel.dart';
import '../../../domain/styles.dart';

class Breadcrum extends StatelessWidget {
  final DesktopFilePickerViewModel model;

  const Breadcrum({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = model.themeSettings;

    return LayoutBuilder(
      builder: (p0, p1) => Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: (p1.maxWidth - 5),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.all(20),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => theme?.buttonColor),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        theme?.mediumRadius ?? 6,
                      ),
                    ),
                  ),
                ),
                onPressed: (() => model.changeMountPoint()),
                icon: Icon(
                  Icons.folder_open,
                  color: theme?.mainTextColor ?? ThemeColors.mainText,
                  size: 48,
                ),
                label: Container(
                  width: (p1.maxWidth - 5),
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Text(
                    model.selectedDomainFolder?.name ?? '',
                    style: TextStyle(
                        color: theme?.mainTextColor ?? ThemeColors.mainText,
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
