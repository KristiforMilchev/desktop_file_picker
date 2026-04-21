import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/models/theme_data.dart';
import '../../domain/styles.dart';

class Utilities {
  static String getFileExtension(String file) {
    return file.split('.').last;
  }

  static String getFileName(String file) {
    final result = file.split(Platform.pathSeparator).last.split(".").first;

    if (result.isEmpty) return getFolderName(file);

    return result;
  }

  static Future<DateTime?> convertDateAsync(File e) async {
    try {
      return await e.lastModified();
    } catch (_) {
      return null;
    }
  }

  static Future<String> convertSizeAsync(File e) async {
    try {
      final result = await e.length();
      return result.toString();
    } catch (_) {
      return "";
    }
  }

  static String getFolderName(String path) {
    return path.split(Platform.pathSeparator).last;
  }

  static IconData getExtensionIcon(String path) {
    final extension = getFileExtension(path).toLowerCase();

    switch (extension) {
      case "zip":
      case "rar":
        return Icons.archive_outlined;

      case "mp3":
        return Icons.music_note_outlined;

      case "mp4":
      case "mov":
      case "wmv":
      case "avi":
      case "avchd":
      case "flv":
      case "f4v":
      case "swf":
      case "mkv":
      case "webm":
        return Icons.video_file;

      case "png":
      case "jpeg":
      case "jpg":
      case "tiff":
      case "gif":
      case "psd":
      case "eps":
      case "ai":
        return Icons.image_sharp;

      default:
        return Icons.file_open;
    }
  }

  static PickerThemeData getDefaultTheme(BuildContext context) {
    final theme = Theme.of(context);

    double resolvedSmall = 4;
    double resolvedMedium = 6;
    double resolvedLarge = 8;

    final inputBorder = theme.inputDecorationTheme.border ??
        theme.inputDecorationTheme.enabledBorder ??
        theme.inputDecorationTheme.focusedBorder;

    if (inputBorder is OutlineInputBorder) {
      final radius = inputBorder.borderRadius.resolve(TextDirection.ltr);
      resolvedSmall = radius.topLeft.x;
    }

    final cardShape = theme.cardTheme.shape;
    if (cardShape is RoundedRectangleBorder) {
      final radius = cardShape.borderRadius.resolve(TextDirection.ltr);
      resolvedMedium = radius.topLeft.x;
    } else {
      resolvedMedium = resolvedSmall;
    }

    final dialogShape = theme.dialogTheme.shape;
    if (dialogShape is RoundedRectangleBorder) {
      final radius = dialogShape.borderRadius.resolve(TextDirection.ltr);
      resolvedLarge = radius.topLeft.x;
    } else {
      resolvedLarge = resolvedMedium;
    }

    return PickerThemeData(
      mainTextColor: theme.textTheme.bodyMedium?.color ?? ThemeColors.mainText,
      mainBackground: theme.scaffoldBackgroundColor,
      inputColor: theme.inputDecorationTheme.fillColor ?? theme.cardColor,
      inputBorderColor:
          theme.inputDecorationTheme.enabledBorder is OutlineInputBorder
              ? (theme.inputDecorationTheme.enabledBorder as OutlineInputBorder)
                  .borderSide
                  .color
              : ThemeColors.mainText,
      inputFocusColor: theme.colorScheme.primary,
      breadCrumbBackground: theme.cardColor,
      selectedItemColor: theme.colorScheme.secondaryContainer,
      buttonColor: theme.colorScheme.primaryContainer,
      imageIcon: Icons.image_sharp,
      videoIcon: Icons.video_file,
      musicIcon: Icons.music_note_outlined,
      archiveIcon: Icons.archive_outlined,
      fileIcon: Icons.file_open,
      folderIcon: Icons.folder,
      radiusSmall: resolvedSmall,
      radiusMedium: resolvedMedium,
      radiusLarge: resolvedLarge,
    );
  }

  static PickerThemeData overrideDefault(
    PickerThemeData pickerThemeData,
    BuildContext context,
  ) {
    final base = getDefaultTheme(context);

    return PickerThemeData(
      mainTextColor: pickerThemeData.mainTextColor ?? base.mainTextColor,
      mainBackground: pickerThemeData.mainBackground ?? base.mainBackground,
      inputColor: pickerThemeData.inputColor ?? base.inputColor,
      inputBorderColor:
          pickerThemeData.inputBorderColor ?? base.inputBorderColor,
      inputFocusColor: pickerThemeData.inputFocusColor ?? base.inputFocusColor,
      breadCrumbBackground:
          pickerThemeData.breadCrumbBackground ?? base.breadCrumbBackground,
      selectedItemColor:
          pickerThemeData.selectedItemColor ?? base.selectedItemColor,
      buttonColor: pickerThemeData.buttonColor ?? base.buttonColor,
      imageIcon: pickerThemeData.imageIcon ?? base.imageIcon,
      videoIcon: pickerThemeData.videoIcon ?? base.videoIcon,
      musicIcon: pickerThemeData.musicIcon ?? base.musicIcon,
      archiveIcon: pickerThemeData.archiveIcon ?? base.archiveIcon,
      fileIcon: pickerThemeData.fileIcon ?? base.fileIcon,
      folderIcon: pickerThemeData.folderIcon ?? base.folderIcon,
      radiusSmall: pickerThemeData.radiusSmall ?? base.radiusSmall,
      radiusMedium: pickerThemeData.radiusMedium ?? base.radiusMedium,
      radiusLarge: pickerThemeData.radiusLarge ?? base.radiusLarge,
    );
  }
}
