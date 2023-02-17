import 'package:desktop_file_picker/src/presentation/components/breadcrum/breadcrum.dart';
import 'package:desktop_file_picker/src/presentation/components/navigation_controls/navigation_controls.dart';
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
      onViewModelReady: (viewModel) => viewModel.initialize(
        isSingleFile,
        isSingleFolder,
        isMultipleFiles,
        extensions ?? [],
        themeSettings,
        callbackCancel,
        callbackConfirm,
        context,
      ),
      builder: (context, model, child) => Material(
        color: model.themeSettings!.mainBackground,
        child: NotificationListener(
          onNotification: (notification) {
            model.gridResized();
            return true;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Breadcrum(model: model),
              NavigationControls(
                model: model,
              ),
              Visibility(
                visible: model.isMountPointSelected,
                replacement: Expanded(
                  flex: 2,
                  child: GridView.count(
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
                                              ? model.themeSettings!
                                                  .selectedItemColor!
                                              : Colors.transparent),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      color: e.isSelected
                                          ? model
                                              .themeSettings!.selectedItemColor
                                          : Colors.transparent),
                                  child: Row(children: [
                                    Icon(
                                      e.icon,
                                      size: 60,
                                      color: model.themeSettings!.mainTextColor,
                                    ),
                                    Container(
                                      width: (p1.maxWidth - 90),
                                      decoration: BoxDecoration(),
                                      clipBehavior: Clip.antiAlias,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            e.name,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: model.themeSettings!
                                                    .mainTextColor),
                                          ),
                                          Text(
                                            e.modifiedDate != null
                                                ? e.modifiedDate!
                                                    .toIso8601String()
                                                : "",
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: model.themeSettings!
                                                    .mainTextColor),
                                          ),
                                          Text(
                                            e.size,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                color: model.themeSettings!
                                                    .mainTextColor),
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
                  ),
                ),
                child: Expanded(
                  flex: 2,
                  child: GridView.count(
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
                                              ? model.themeSettings!
                                                  .selectedItemColor!
                                              : Colors.transparent),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      color: e.isSelected
                                          ? model
                                              .themeSettings!.selectedItemColor
                                          : Colors.transparent),
                                  child: Row(children: [
                                    Icon(
                                      e.icon,
                                      size: 60,
                                      color: model.themeSettings!.mainTextColor,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          e.name,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: model.themeSettings!
                                                  .mainTextColor),
                                        ),
                                        Text(
                                          e.modifiedDate != null
                                              ? e.modifiedDate!
                                                  .toIso8601String()
                                              : "",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: model.themeSettings!
                                                  .mainTextColor),
                                        ),
                                        Text(
                                          e.size,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: model.themeSettings!
                                                  .mainTextColor),
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
                  ),
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
                          fixedSize:
                              const MaterialStatePropertyAll(Size(150, 50)),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => model.themeSettings!.buttonColor),
                        ),
                        onPressed: (() => model.dialogCancel()),
                        child: const Text("Cancel")),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          fixedSize:
                              const MaterialStatePropertyAll(Size(150, 50)),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => model.themeSettings!.buttonColor),
                        ),
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
