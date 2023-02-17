import 'package:flutter/material.dart';

import '../../../desktop_file_picker_viewmodel.dart';
import '../../../domain/styles.dart';

// ignore: must_be_immutable
class DiskContentGrid extends StatelessWidget {
  late DesktopFilePickerViewModel model;

  DiskContentGrid({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      shrinkWrap: true,
      childAspectRatio: 3,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 2,
      mainAxisSpacing: 0,
      crossAxisCount: model.axieItemCount,
      children: model.folderContent
          .map(
            (e) => Visibility(
              visible: e.isVisible,
              child: LayoutBuilder(
                builder: (p0, p1) => InkWell(
                  onDoubleTap: () => model.folderSelected(e),
                  onTap: () => model.gridElementSelected(e),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: ThemeColors.setBorder(
                            0,
                            e.isSelected
                                ? model.themeSettings!.selectedItemColor!
                                : Colors.transparent),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: e.isSelected
                            ? model.themeSettings!.selectedItemColor
                            : Colors.transparent),
                    child: Row(children: [
                      Icon(
                        e.icon,
                        size: 60,
                        color: model.themeSettings!.mainTextColor,
                      ),
                      Container(
                        width: (p1.maxWidth - 90),
                        decoration: const BoxDecoration(),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              e.name,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: model.themeSettings!.mainTextColor),
                            ),
                            Text(
                              e.modifiedDate != null
                                  ? e.modifiedDate!.toIso8601String()
                                  : "",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: model.themeSettings!.mainTextColor),
                            ),
                            Text(
                              e.size,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: model.themeSettings!.mainTextColor),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
