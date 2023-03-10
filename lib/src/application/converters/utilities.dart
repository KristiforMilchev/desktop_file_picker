import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/models/theme_data.dart';
import '../../domain/styles.dart';

class Utilities {
  static String getFileExtension(String file) {
    return file.split('.').last;
  }

  static String getFileName(String file) {
    var result = file.split(Platform.pathSeparator).last.split(".").first;

    if (result.isEmpty) return getFolderName(file);

    return result;
  }

  static Future<DateTime?> convertDateAsync(File e) async {
    try {
      var result = await e.lastModified();
      return result;
    } catch (exception) {
      return null;
    }
  }

  static Future<String> convertSizeAsync(File e) async {
    try {
      var result = await e.length();
      return result.toString();
    } catch (exception) {
      return "";
    }
  }

  static String getFolderName(String path) {
    return path.split(Platform.pathSeparator).last;
  }

  static IconData getExtensionIcon(String path) {
    var extension = getFileExtension(path);
    IconData icon;
    switch (extension) {
      case "zip":
        icon = Icons.archive_outlined;
        break;
      case "rar":
        icon = Icons.archive_outlined;
        break;
      case "mp3":
        icon = Icons.music_note_outlined;
        break;
      case "mp4":
        icon = Icons.video_file;
        break;
      case "mov":
        icon = Icons.video_file;
        break;
      case "wmv":
        icon = Icons.video_file;
        break;
      case "avi":
        icon = Icons.video_file;
        break;
      case "avchd":
        icon = Icons.video_file;
        break;
      case "flv":
        icon = Icons.video_file;
        break;
      case "f4v":
        icon = Icons.video_file;
        break;
      case "swf":
        icon = Icons.video_file;
        break;
      case "mkv":
        icon = Icons.video_file;
        break;
      case "webm":
        icon = Icons.video_file;
        break;
      case "png":
        icon = Icons.image_sharp;
        break;
      case "jpeg":
        icon = Icons.image_sharp;
        break;
      case "tiff":
        icon = Icons.image_sharp;
        break;
      case "gif":
        icon = Icons.image_sharp;
        break;
      case "psd":
        icon = Icons.image_sharp;
        break;
      case "esp":
        icon = Icons.image_sharp;
        break;
      case "ai":
        icon = Icons.image_sharp;
        break;
      default:
        icon = Icons.file_open;
        break;
    }

    return icon;
  }

  static PickerThemeData getDefaultTheme() {
    return PickerThemeData(
      mainTextColor: ThemeColors.mainText,
      mainBackground: ThemeColors.mainThemeBackground,
      inputColor: ThemeColors.mainText,
      inputBorderColor: ThemeColors.mainText,
      inputFocusColor: ThemeColors.innerText,
      breadCrumbBackground: ThemeColors.cardBackground,
      selectedItemColor: ThemeColors.cardBackground,
      buttonColor: ThemeColors.cardBackground,
      imageIcon: Icons.image_sharp,
      videoIcon: Icons.video_file,
      musicIcon: Icons.music_note_outlined,
      archiveIcon: Icons.archive_outlined,
      fileIcon: Icons.file_open,
      folderIcon: Icons.folder,
    );
  }

  static PickerThemeData overrideDefault(PickerThemeData pickerThemeData) {
    return PickerThemeData(
      mainTextColor: pickerThemeData.mainTextColor ?? ThemeColors.mainText,
      mainBackground:
          pickerThemeData.mainBackground ?? ThemeColors.mainThemeBackground,
      inputColor: pickerThemeData.inputColor ?? ThemeColors.mainText,
      inputBorderColor:
          pickerThemeData.inputBorderColor ?? ThemeColors.mainText,
      inputFocusColor: pickerThemeData.inputFocusColor ?? ThemeColors.innerText,
      breadCrumbBackground:
          pickerThemeData.breadCrumbBackground ?? ThemeColors.cardBackground,
      selectedItemColor:
          pickerThemeData.selectedItemColor ?? ThemeColors.cardBackground,
      buttonColor: pickerThemeData.buttonColor ?? ThemeColors.cardBackground,
      imageIcon: pickerThemeData.imageIcon ?? Icons.image_sharp,
      videoIcon: pickerThemeData.videoIcon ?? Icons.video_file,
      musicIcon: pickerThemeData.musicIcon ?? Icons.music_note_outlined,
      archiveIcon: pickerThemeData.archiveIcon ?? Icons.archive_outlined,
      fileIcon: pickerThemeData.fileIcon ?? Icons.file_open,
      folderIcon: pickerThemeData.folderIcon ?? Icons.folder,
    );
  }
}
