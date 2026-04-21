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

class FileSelector extends StatelessWidget {
  final bool? isSingleFile;
  final bool? isSingleFolder;
  final bool? isMultipleFiles;
  final PickerThemeData? themeSettings;
  final Function callbackConfirm;
  final Function callbackCancel;
  final List<String>? extensions;

  const FileSelector({
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
    final getIt = GetIt.I;
    if (!getIt.isRegistered<IFileManager>()) {
      getIt.registerSingleton<IFileManager>(FileManager());
    }

    return ViewModelBuilder<DesktopFilePickerViewModel>.reactive(
      viewModelBuilder: () => DesktopFilePickerViewModel(),
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
      builder: (context, model, child) {
        final background = model.themeSettings?.mainBackground ?? Colors.white;
        final textColor = model.themeSettings?.mainTextColor ?? Colors.black;

        if (!model.isInitialized) {
          return Material(
            color: background,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Material(
          color: background,
          child: Column(
            children: [
              Breadcrum(model: model),
              NavigationControls(model: model),
              Expanded(
                child: model.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ContentGrid(model: model),
              ),
              Divider(color: textColor),
              PickerConfirmationbox(model: model),
            ],
          ),
        );
      },
    );
  }
}
