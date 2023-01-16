import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'desktop_file_picker_viewmodel.dart';
import 'domain/styles.dart';

class FileSelector extends StatelessWidget {
  const FileSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: (() => DesktopFilePickerViewModel()),
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, model, child) => Material(
        color: ThemeColors.mainThemeBackground,
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "C:",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ThemeColors.mainText,
                        fontSize: 48,
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
                    Text(
                      "Go back",
                      style: TextStyle(
                        color: ThemeColors.mainText,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Sort by name",
                      style: TextStyle(
                        color: ThemeColors.mainText,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Sort by date",
                      style: TextStyle(
                        color: ThemeColors.mainText,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Sort by size",
                      style: TextStyle(
                        color: ThemeColors.mainText,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Sort by type",
                      style: TextStyle(
                        color: ThemeColors.mainText,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  primary: false,
                  shrinkWrap: false,
                  childAspectRatio: 3,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 0,
                  crossAxisCount: 4,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(children: [
                        Icon(
                          Icons.image,
                          size: 60,
                          color: ThemeColors.mainText,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "some awesome image.png",
                                style: TextStyle(color: ThemeColors.mainText),
                              ),
                              Text(
                                "05/06/2022 11:23 pm",
                                style: TextStyle(color: ThemeColors.mainText),
                              ),
                              Text(
                                "106 Kb",
                                style: TextStyle(color: ThemeColors.mainText),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: ThemeColors.setBorder(0, Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: Colors.transparent),
                      child: Row(children: [
                        Icon(
                          Icons.folder,
                          size: 60,
                          color: ThemeColors.mainText,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "some awesome image.png",
                                style: TextStyle(color: ThemeColors.mainText),
                              ),
                              Text(
                                "05/06/2022 11:23 pm",
                                style: TextStyle(color: ThemeColors.mainText),
                              ),
                              Text(
                                "106 Kb",
                                style: TextStyle(color: ThemeColors.mainText),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                    Row(children: [
                      Icon(
                        Icons.image,
                        size: 60,
                        color: ThemeColors.mainText,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "some awesome image.png",
                              style: TextStyle(color: ThemeColors.mainText),
                            ),
                            Text(
                              "05/06/2022 11:23 pm",
                              style: TextStyle(color: ThemeColors.mainText),
                            ),
                            Text(
                              "106 Kb",
                              style: TextStyle(color: ThemeColors.mainText),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      )
                    ]),
                    Row(children: [
                      Icon(
                        Icons.image,
                        size: 60,
                        color: ThemeColors.mainText,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "some awesome image.png",
                              style: TextStyle(color: ThemeColors.mainText),
                            ),
                            Text(
                              "05/06/2022 11:23 pm",
                              style: TextStyle(color: ThemeColors.mainText),
                            ),
                            Text(
                              "106 Kb",
                              style: TextStyle(color: ThemeColors.mainText),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      )
                    ]),
                    Row(children: [
                      Icon(
                        Icons.image,
                        size: 60,
                        color: ThemeColors.mainText,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "some awesome image.png",
                              style: TextStyle(color: ThemeColors.mainText),
                            ),
                            Text(
                              "05/06/2022 11:23 pm",
                              style: TextStyle(color: ThemeColors.mainText),
                            ),
                            Text(
                              "106 Kb",
                              style: TextStyle(color: ThemeColors.mainText),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      )
                    ]),
                  ],
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
                        onPressed: (() => {}), child: Text("Cancel")),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(onPressed: (() => {}), child: Text("ok"))
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
