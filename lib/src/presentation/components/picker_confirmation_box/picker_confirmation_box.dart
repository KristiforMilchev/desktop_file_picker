import 'package:flutter/material.dart';

import '../../../desktop_file_picker_viewmodel.dart';

// ignore: must_be_immutable
class PickerConfirmationbox extends StatelessWidget {
  late DesktopFilePickerViewModel model;

  PickerConfirmationbox({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
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
                fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => model.themeSettings!.buttonColor),
              ),
              onPressed: (() => model.confirmPressed()),
              child: const Text("ok"))
        ],
      ),
    );
  }
}
