import 'package:flutter/material.dart';

import '../../../desktop_file_picker_viewmodel.dart';
import '../../../domain/styles.dart';

// ignore: must_be_immutable
class DriveContentGrid extends StatelessWidget {
  late DesktopFilePickerViewModel model;

  DriveContentGrid({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      shrinkWrap: false,
      childAspectRatio: 3,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 2,
      mainAxisSpacing: 0,
      crossAxisCount: 4,
      children: model.commonPaths
          .map(
            (e) => Visibility(
              visible: e.isVisible,
              child: SizedBox(
                width: 300,
                child: InkWell(
                  onTap: () => model.commonPathSelected(e),
                  child: Container(
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
                      Column(
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
