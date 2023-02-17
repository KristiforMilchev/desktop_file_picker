import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../desktop_file_picker_viewmodel.dart';
import '../../../../domain/styles.dart';

// ignore: must_be_immutable
class MediumNavigation extends StatelessWidget {
  DesktopFilePickerViewModel model;

  MediumNavigation({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => model.themeSettings!.buttonColor)),
                  onPressed: (() => model.returnFolder()),
                  icon: Icon(
                    Icons.backspace,
                    color: model.themeSettings!.mainTextColor,
                  ),
                  label: Text(
                    "Go back",
                    style: TextStyle(
                      color: model.themeSettings!.mainTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 6,
                child: TextField(
                  style: TextStyle(
                    color: model.themeSettings!.mainTextColor,
                    fontSize: 12,
                    height: 2,
                  ),
                  onChanged: (value) => model.searchChanged(value),
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxHeight: 35),
                    enabledBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: BorderSide(
                          color: model.themeSettings!.inputBorderColor!,
                          width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: BorderSide(
                          color: model.themeSettings!.inputBorderColor!,
                          width: 0.0),
                    ),
                    border: const OutlineInputBorder(),
                    focusColor: model.themeSettings!.inputFocusColor,
                    hoverColor: ThemeColors.activeMenu,
                    fillColor: model.themeSettings!.mainTextColor,
                    hintStyle: TextStyle(
                      color: model.themeSettings!.mainTextColor,
                    ),
                    hintText: "Search for files and folders by name",
                    label: Text(
                      "Search",
                      style: TextStyle(
                        color: model.themeSettings!.mainTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => model.themeSettings!.buttonColor),
                ),
                onPressed: (() => model.sortByName()),
                icon: Icon(
                  Icons.text_format,
                  color: model.themeSettings!.mainTextColor,
                ),
                label: Text(
                  "Sort by name",
                  style: TextStyle(
                    color: model.themeSettings!.mainTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => model.themeSettings!.buttonColor),
                ),
                onPressed: (() => model.sortByDate()),
                icon: Icon(
                  Icons.date_range,
                  color: model.themeSettings!.mainTextColor,
                ),
                label: Text(
                  "Sort by date",
                  style: TextStyle(
                    color: model.themeSettings!.mainTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => model.themeSettings!.buttonColor),
                ),
                onPressed: (() => model.sortBySize()),
                icon: Icon(
                  Icons.summarize,
                  color: model.themeSettings!.mainTextColor,
                ),
                label: Text(
                  "Sort by size",
                  style: TextStyle(
                    color: model.themeSettings!.mainTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => model.themeSettings!.buttonColor),
                ),
                onPressed: (() => model.sortByType()),
                icon: Icon(
                  Icons.type_specimen,
                  color: model.themeSettings!.mainTextColor,
                ),
                label: Text(
                  "Sort by type",
                  style: TextStyle(
                    color: model.themeSettings!.mainTextColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
