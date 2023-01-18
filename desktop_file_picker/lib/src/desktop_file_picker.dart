import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import 'application/file_manager.dart';
import 'desktop_file_picker_viewmodel.dart';
import 'domain/styles.dart';
import 'infrastructure/ifile_manager.dart';

class FileSelector extends StatelessWidget {
  late bool? isSingleFile = true;
  late bool? isSingleFolder = false;
  late bool? isMultipleFiles = false;
  late Function callbackConfirm;
  late Function callbackCancel;

  List<String>? extensions = [];
  FileSelector({
    super.key,
    this.isSingleFile,
    this.isMultipleFiles,
    this.isSingleFolder,
    this.extensions,
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
          callbackCancel,
          callbackConfirm),
      builder: (context, model, child) => Material(
        color: ThemeColors.mainThemeBackground,
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
                              (states) => ThemeColors.cardBackground),
                        ),
                        onPressed: (() => {}),
                        icon: Icon(
                          Icons.folder_open,
                          color: ThemeColors.mainText,
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
                                (states) => ThemeColors.cardBackground)),
                        onPressed: (() => model.returnFolder()),
                        icon: Icon(
                          Icons.backspace,
                          color: ThemeColors.mainText,
                        ),
                        label: Text(
                          "Go back",
                          style: TextStyle(
                            color: ThemeColors.mainText,
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
                            color: ThemeColors.mainText,
                            fontSize: 12,
                            height: 2,
                          ),
                          onChanged: (value) => model.searchChanged(value),
                          decoration: InputDecoration(
                            constraints: BoxConstraints(maxHeight: 35),
                            enabledBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: BorderSide(
                                  color: ThemeColors.mainText, width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              // width: 0.0 produces a thin "hairline" border
                              borderSide: BorderSide(
                                  color: ThemeColors.mainText, width: 0.0),
                            ),
                            border: const OutlineInputBorder(),
                            focusColor: ThemeColors.innerText,
                            hoverColor: ThemeColors.activeMenu,
                            fillColor: ThemeColors.mainText,
                            hintStyle: TextStyle(
                              color: ThemeColors.innerText,
                            ),
                            hintText: "Search for files and folders by name",
                            label: Text(
                              "Search",
                              style: TextStyle(
                                color: ThemeColors.mainText,
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
                                  MaterialStateProperty.resolveWith(
                                      (states) => ThemeColors.cardBackground)),
                          onPressed: (() => {}),
                          icon: Icon(
                            Icons.text_format,
                            color: ThemeColors.mainText,
                          ),
                          label: Text(
                            "Sort by name",
                            style: TextStyle(
                              color: ThemeColors.mainText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => ThemeColors.cardBackground)),
                          onPressed: (() => {}),
                          icon: Icon(
                            Icons.date_range,
                            color: ThemeColors.mainText,
                          ),
                          label: Text(
                            "Sort by date",
                            style: TextStyle(
                              color: ThemeColors.mainText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => ThemeColors.cardBackground)),
                          onPressed: (() => {}),
                          icon: Icon(
                            Icons.summarize,
                            color: ThemeColors.mainText,
                          ),
                          label: Text(
                            "Sort by size",
                            style: TextStyle(
                              color: ThemeColors.mainText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => ThemeColors.cardBackground)),
                          onPressed: (() => {}),
                          icon: Icon(
                            Icons.type_specimen,
                            color: ThemeColors.mainText,
                          ),
                          label: Text(
                            "Sort by type",
                            style: TextStyle(
                              color: ThemeColors.mainText,
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
                                          ? ThemeColors.cardBackground
                                          : Colors.transparent),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  color: e.isSelected
                                      ? ThemeColors.cardBackground
                                      : Colors.transparent),
                              child: Row(children: [
                                Icon(
                                  e.icon,
                                  size: 60,
                                  color: ThemeColors.mainText,
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
                                            color: ThemeColors.mainText),
                                      ),
                                      Text(
                                        e.modifiedDate,
                                        style: TextStyle(
                                            color: ThemeColors.mainText),
                                      ),
                                      Text(
                                        e.size,
                                        style: TextStyle(
                                            color: ThemeColors.mainText),
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
                                (states) => ThemeColors.cardBackground)),
                        onPressed: (() => model.dialogCancel()),
                        child: const Text("Cancel")),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => ThemeColors.cardBackground)),
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
