import 'package:flutter/material.dart';
import 'package:text_editor/src/font_option_model.dart';
import 'package:text_editor/text_editor.dart';
import 'package:text_editor/text_editor_data.dart';

class FontFamily extends StatefulWidget {
  final List<FontFamilyModel> fonts;
  final FontDecoration? fontDecoration;

  FontFamily(this.fonts, this.fontDecoration);

  @override
  _FontFamilyState createState() => _FontFamilyState();
}

class _FontFamilyState extends State<FontFamily> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.fonts.map((fontModel) => _FontFamilyPicker(fontModel.font, fontModel.isSelected, widget.fontDecoration)).toList(),
        ),
      ),
    );
  }
}

class _FontFamilyPicker extends StatelessWidget {
  final String font;
  final bool isSelected;
  final FontDecoration? fontDecoration;

  _FontFamilyPicker(this.font, this.isSelected, this.fontDecoration);

  @override
  Widget build(BuildContext context) {
    final fontOptionModel = TextEditorData.read(context).fontOptionModel;

    return GestureDetector(
      onTap: () => fontOptionModel.selectFontFamily(font),
      child: Container(
        width: fontDecoration?.size?.width ?? 40,
        height: fontDecoration?.size?.height ?? 40,
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: fontDecoration?.radius ?? BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Aa',
            style: TextStyle(
              color: isSelected ? fontDecoration?.fontActiveColor ?? Colors.orange : fontDecoration?.fontColor ?? Colors.white,
              fontFamily: font,
            ),
          ),
        ),
      ),
    );
  }
}
