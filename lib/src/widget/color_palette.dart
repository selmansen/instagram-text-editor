import 'package:flutter/material.dart';
import 'package:text_editor/text_editor_data.dart';

class ColorPalette extends StatefulWidget {
  final List<Color> colors;
  final bool visibleColorize;

  ColorPalette(this.colors, this.visibleColorize);

  @override
  _ColorPaletteState createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  @override
  Widget build(BuildContext context) {
    final textStyleModel = TextEditorData.of(context).textStyleModel;
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (widget.visibleColorize == true)
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: textStyleModel.textStyle?.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Icon(
                    Icons.colorize,
                    color: Colors.white,
                  ),
                ),
              ),
            ...widget.colors.map((color) => _ColorPicker(color)).toList(),
          ],
        ),
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  final Color color;

  _ColorPicker(this.color);

  @override
  Widget build(BuildContext context) {
    final textStyleModel = TextEditorData.read(context).textStyleModel;

    return GestureDetector(
      onTap: () => textStyleModel.editTextColor(color),
      child: Container(
        width: 20,
        height: 20,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
