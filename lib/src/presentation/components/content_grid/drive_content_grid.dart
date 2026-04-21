import 'package:flutter/material.dart';

import '../../../desktop_file_picker_viewmodel.dart';
import '../../../domain/styles.dart';

class DriveContentGrid extends StatelessWidget {
  final DesktopFilePickerViewModel model;

  const DriveContentGrid({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final items = model.commonPaths.where((e) => e.isVisible).toList();
    final textColor = model.themeSettings!.mainTextColor;
    final selectedColor = model.themeSettings!.selectedItemColor!;

    return GridView.builder(
      primary: false,
      shrinkWrap: false,
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisExtent: 86,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemBuilder: (context, index) {
        final e = items[index];

        return RepaintBoundary(
          child: InkWell(
            onTap: () => model.commonPathSelected(e),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                border: ThemeColors.setBorder(
                  0,
                  e.isSelected ? selectedColor : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(
                  model.themeSettings!.mediumRadius,
                ),
                color: e.isSelected ? selectedColor : Colors.transparent,
              ),
              child: Row(
                children: [
                  Icon(
                    e.icon,
                    size: 48,
                    color: textColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          e.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textColor,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          e.modifiedDate?.toIso8601String() ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          e.size,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            height: 1.1,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
