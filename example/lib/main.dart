import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'main_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const smallRadius = 2.0;
    const mediumRadius = 4.0;
    const largeRadius = 6.0;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 49, 55, 72),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 35, 72, 114),
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color.fromARGB(255, 28, 40, 54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(smallRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(smallRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(smallRadius),
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color.fromARGB(255, 28, 40, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(mediumRadius),
          ),
        ),
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(largeRadius),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 35, 72, 114),
            fixedSize: const Size(150, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(smallRadius),
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Desktop file picker demo application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => MainViewModel(),
      onViewModelReady: (viewModel) => viewModel.ready(context),
      builder: (context, viewModel, child) => Scaffold(
        backgroundColor: const Color.fromARGB(255, 49, 55, 72),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Desktop file picker demo app",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: const [
                          Text(
                            "Supported Features",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Selecting a single file",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Selecting an entire folder",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Selecting multiple files",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Filtering by Extension type",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            "Next version updates",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Save file dialog",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Drop file box",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Better Logging",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Changelog",
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 500,
                            width: 600,
                            child: ListView.builder(
                              itemCount: viewModel.changeLog.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  Text(
                                    viewModel.changeLog
                                        .elementAt(index)
                                        .version,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  ...viewModel.changeLog
                                      .elementAt(index)
                                      .changes
                                      .map(
                                        (e) => Text(
                                          e,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => viewModel.selectSingleFile(),
                          child: const Text("Pick a single file"),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color.fromARGB(255, 28, 40, 54),
                          ),
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            "Selected File: ${viewModel.singleFileSelected ?? ""}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => viewModel.selectFolder(),
                          child: const Text("Pick a folder"),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color.fromARGB(255, 28, 40, 54),
                            ),
                            height: 100,
                            child: ListView.builder(
                              itemCount: viewModel.folderSelected != null
                                  ? viewModel.folderSelected!.length
                                  : 0,
                              itemBuilder: (context, index) => Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Selected Folder: ${viewModel.folderSelected?.elementAt(index)}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () => viewModel.selectFiles(),
                          child: const Text("Multiple Files"),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color.fromARGB(255, 28, 40, 54),
                            ),
                            child: ListView.builder(
                              itemCount: viewModel.filesSelected != null
                                  ? viewModel.filesSelected!.length
                                  : 0,
                              itemBuilder: (context, index) => Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "${viewModel.filesSelected?.elementAt(index)}",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
