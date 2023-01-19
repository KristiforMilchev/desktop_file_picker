
# Desktop File Picker

desktop_file_picker package lets you initialize a desktop file picker written in dart.

# Supported filters

By name
By type
By drive
By size
By date
By name

# Supported Modes
Single file
Multople Files
Single Folder

## Installation 

1. Add the latest version of package to your pubspec.yaml (and run`flutter pub get`):
```yaml
dependencies:
  desktop_file_picker: ^0.0.1
```
2. Import the package and use it in your Flutter App.
```dart
import 'package:desktop_file_picker/desktop_file_picker.dart';
```

## Customizing the picker
There are a number of properties that you can modify:

 - Main background
 - Font color               
 - Icons 
 - Button Color
 - Input Color
 - Input border color
 - Selected item color
 - Main Text Color

<hr>

<table>
<tr>
<td>

```dart
class DesktopPickerView extends StatelessWidget {  
  const DesktopPickerView({Key? key}) : super(key: key);  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: Center(  
        child:  FileSelector(
            isSingleFolder: true,
            callbackCancel: () => Navigator.of(context).pop(),
            callbackConfirm: (data) {
                Navigator.of(context).pop();
                confirmCallBack.call(data);
            })
      ),  
    );  
  }  
}
```

</td>
<td>
<img  src="https://linksync.tech/picker.png"  alt="">
</td>
</tr>
</table>

## Next Goals

 - [] Add save file dialog option.
 Now, you can specify the onTap and specify a function.
 