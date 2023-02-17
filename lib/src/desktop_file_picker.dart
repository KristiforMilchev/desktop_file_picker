import 'package:desktop_file_picker/src/presentation/components/breadcrum/breadcrum.dart';
import 'package:desktop_file_picker/src/presentation/components/content_grid/content_grid.dart';
import 'package:desktop_file_picker/src/presentation/components/navigation_controls/navigation_controls.dart';
import 'package:desktop_file_picker/src/presentation/components/picker_confirmation_box/picker_confirmation_box.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

import 'application/file_manager.dart';
import 'desktop_file_picker_viewmodel.dart';
import 'domain/models/theme_data.dart';
import 'domain/styles.dart';
import 'infrastructure/ifile_manager.dart';

//TODO Important, decopule the main ViewModel and separate all the concenrns into the newly created components
//TODO Things like the grid loading and binding, drive binding, folder navigation has to happen inside the content grid view models
//TODO Saving and picking should only happen inside the PickerConfirmationViewModel etc.

// ignore: must_be_immutable
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
              ContentGrid(model: model),
              Divider(
                color: ThemeColors.mainText,
              ),
              PickerConfirmationbox(model: model)
            ],
          ),
        ),
      ),
    );
  }
}
