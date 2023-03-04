import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class PlayerFormWidget extends StatelessWidget {
  final Color? color;
  //final String? image;
  final String? name;

  final ValueChanged<Color> onChangedColor;
  //final ValueChanged<String> onChangedImage;
  final ValueChanged<String> onChangedName;

  PlayerFormWidget({
    Key? key,
    this.color = Colors.red,
    //this.image = '',
    this.name = '',
    required this.onChangedColor,
    required this.onChangedName,
    //required this.onChangedImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              const SizedBox(height: 8),
              //buildDescription(),
              const SizedBox(height: 16),
              buildColor(context)
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: name,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Name',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (name) {
          if (name != null) {
            if (name.isEmpty) {
              return 'The name cannot be empty!';
            } else if (name.length > 12) {
              return 'The name is too long (max 12 charaters)';
            } else {
              return null;
            }
          } else {
            return null;
          }
        },
        onChanged: onChangedName,
      );

  /*Widget buildDescription() => TextFormField(
        maxLines: 5,
        //initialValue: image,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type image url...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (image) =>
            image != null && image.isEmpty ? 'The url cannot be empty' : null,
        //onChanged: onChangedImage,
      );
  */

  Widget buildColor(BuildContext context) => Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: () => pickColor(context),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14)),
                child: const Text(
                  'Pick Color',
                  style: TextStyle(fontSize: 24),
                ))
          ],
        ),
      );

  Widget buildColorPicker() => ColorPicker(
        onColorChanged: onChangedColor,
        pickersEnabled: const <ColorPickerType, bool>{
          ColorPickerType.both: false,
          ColorPickerType.primary: false,
          ColorPickerType.accent: false,
          ColorPickerType.bw: false,
          ColorPickerType.custom: true,
          ColorPickerType.wheel: true
        },
      );

  void pickColor(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text('Pick Your Color'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildColorPicker(),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "SELECT",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ));
}
