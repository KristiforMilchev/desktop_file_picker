import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import 'application/file_manager.dart';
import 'desktop_file_picker_viewmodel.dart';
import 'domain/models/theme_data.dart';
import 'domain/styles.dart';
import 'infrastructure/ifile_manager.dart';

class FileSelector extends StatelessWidget {
  late bool? isSingleFile = true;
  late bool? isSingleFolder = false;
  late bool? isMultipleFiles = false;
  late PickerThemeData? themeSettings;
  late Function callbackConfirm;
  late Function callbackCancel;

  List<String>? extensions = [];
  FileSelector({
    super.key,
    this.isSingleFile,
    this.isMultipleFiles,
    this.isSingleFolder,
    this.extensions,
    this.themeSettings,
    required this.callbackCancel,
    required this.callbackConfirm,
  });

  @override
  Widget build(BuildContext context) {
    GetIt getIt = GetIt.I;
    if (!getIt.isRegistered<IFileManager>()) {
      getIt.registerSingleton<IFileManager>(FileManager());
    }

    return ViewModelBuilder.reactive(
      viewModelBuilder: (() => DesktopFilePickerViewModel()),
      onModelReady: (viewModel) => viewModel.initialize(
          isSingleFile,
          isSingleFolder,
          isMultipleFiles,
          extensions ?? [],
          themeSettings,
          callbackCancel,
          callbackConfirm),
      builder: (context, model, child) => Material(
        color: model.themeSettings!.mainBackground,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Expanded(
                      flex: 10,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => model.themeSettings!.buttonColor),
                        ),
                        onPressed: (() => {}),
                        icon: Icon(
                          Icons.folder_open,
                          color: model.themeSettings!.mainTextColor,
                          size: 48,
                        ),
                        label: Text(
                          model.selectedDomainFolder!.name,
                          style: TextStyle(
                              color: ThemeColors.mainText, fontSize: 48),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
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
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) =>
                                      model.themeSettings!.buttonColor)),
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) =>
                                      model.themeSettings!.buttonColor)),
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) =>
                                      model.themeSettings!.buttonColor)),
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
                              backgroundColor:
                                  MaterialStateProperty.resolveWith((states) =>
                                      model.themeSettings!.buttonColor)),
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
              ),
              Expanded(
                flex: 2,
                child: GridView.count(
                  primary: false,
                  shrinkWrap: false,
                  childAspectRatio: 3,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 0,
                  crossAxisCount: 4,
                  children: model.folderContent
                      .map(
                        (e) => Visibility(
                          visible: e.isVisible,
                          child: InkWell(
                            onDoubleTap: () => model.folderSelected(e),
                            onTap: () => model.gridElementSelected(e),
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: ThemeColors.setBorder(
                                      0,
                                      e.isSelected
                                          ? model
                                              .themeSettings!.selectedItemColor!
                                          : Colors.transparent),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  color: e.isSelected
                                      ? model.themeSettings!.selectedItemColor
                                      : Colors.transparent),
                              child: Row(children: [
                                Icon(
                                  e.icon,
                                  size: 60,
                                  color: model.themeSettings!.mainTextColor,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        e.name,
                                        style: TextStyle(
                                            color: model
                                                .themeSettings!.mainTextColor),
                                      ),
                                      Text(
                                        e.modifiedDate != null
                                            ? e.modifiedDate!.toIso8601String()
                                            : "",
                                        style: TextStyle(
                                            color: model
                                                .themeSettings!.mainTextColor),
                                      ),
                                      Text(
                                        e.size,
                                        style: TextStyle(
                                            color: model
                                                .themeSettings!.mainTextColor),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Divider(
                color: ThemeColors.mainText,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => model.themeSettings!.buttonColor)),
                        onPressed: (() => model.dialogCancel()),
                        child: const Text("Cancel")),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => model.themeSettings!.buttonColor)),
                        onPressed: (() => model.confirmPressed()),
                        child: const Text("ok"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
