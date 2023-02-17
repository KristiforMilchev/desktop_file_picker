import 'package:desktop_file_picker/src/desktop_file_picker_viewmodel.dart';
import 'package:desktop_file_picker/src/presentation/components/navigation_controls/layouts/large.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'layouts/medium.dart';
import 'layouts/small.dart';
import 'navigation_controls_viewmodel.dart';

// ignore: must_be_immutable
class NavigationControls extends StatelessWidget {
  DesktopFilePickerViewModel model;

  NavigationControls({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => NavigationControlsViewModel(),
      onViewModelReady: (viewModel) => viewModel.ready(context),
      builder: (context, viewModel, child) => NotificationListener(
        onNotification: (notification) {
          viewModel.panelResized();
          return true;
        },
        child: Column(
          children: [
            Visibility(
                visible: viewModel.viewState == 1,
                child: LargeNavigation(
                  model: model,
                )),
            Visibility(
              visible: viewModel.viewState == 2,
              child: MediumNavigation(
                model: model,
              ),
            ),
            Visibility(
              visible: viewModel.viewState == 3,
              child: SmallNavigation(
                model: model,
              ),
            )
          ],
        ),
      ),
    );
  }
}
