import 'package:flutter/material.dart';

import '../../../desktop_file_picker_viewmodel.dart';

class PickerConfirmationbox extends StatelessWidget {
  final DesktopFilePickerViewModel model;

  const PickerConfirmationbox({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = model.themeSettings;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
              style: ButtonStyle(
                fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => theme?.buttonColor),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      theme?.smallRadius ?? 4,
                    ),
                  ),
                ),
              ),
              onPressed: (() => model.dialogCancel()),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: theme?.mainTextColor,
                ),
              )),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
              style: ButtonStyle(
                fixedSize: const MaterialStatePropertyAll(Size(150, 50)),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => theme?.buttonColor),
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      theme?.smallRadius ?? 4,
                    ),
                  ),
                ),
              ),
              onPressed: (() => model.confirmPressed()),
              child: Text(
                "ok",
                style: TextStyle(
                  color: theme?.mainTextColor,
                ),
              ))
        ],
      ),
    );
  }
}
