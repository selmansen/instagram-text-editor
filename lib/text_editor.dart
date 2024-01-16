library text_editor;

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:text_editor/src/font_option_model.dart';
import 'package:text_editor/src/text_style_model.dart';
import 'package:text_editor/src/widget/color_palette.dart';
import 'package:text_editor/src/widget/font_family.dart';
import 'package:text_editor/src/widget/font_size.dart';
import 'package:text_editor/src/widget/font_option_switch.dart';
import 'package:text_editor/src/widget/mentions.dart';
import 'package:text_editor/src/widget/tag.dart';
import 'package:text_editor/src/widget/text_alignment.dart';
import 'package:text_editor/text_editor_data.dart';

import 'src/widget/text_background_color.dart';

/// Instagram like text editor
/// A flutter widget that edit text style and text alignment
///
/// You can pass your text style to the widget
/// and then get the edited text style
class TextEditor extends StatefulWidget {
  ///TextField Controller
  final TextEditingController controller;

  ///Mentions
  final List<MentionList>? mentionList;

  ///Tag
  final List<TagList>? tagList;

  /// Editor's font families
  final List<String> fonts;

  final bool visibleColorize;

  /// font item style
  final FontDecoration? fontDecoration;

  /// After edit process completed, [onEditCompleted] callback will be called.
  final void Function(TextStyle, TextAlign) onEditCompleted;

  /// [onTextAlignChanged] will be called after [textAlingment] prop has changed
  final ValueChanged<TextAlign>? onTextAlignChanged;

  /// [onTextStyleChanged] will be called after [textStyle] prop has changed
  final ValueChanged<TextStyle>? onTextStyleChanged;

  /// [onTextChanged] will be called after [text] prop has changed
  final ValueChanged<String>? onTextChanged;

  /// The text alignment
  final TextAlign? textAlingment;

  /// The text style
  final TextStyle? textStyle;

  /// Widget's background color
  final Color? backgroundColor;

  /// Editor's palette colors
  final List<Color>? paletteColors;

  /// Editor's default text
  final String text;

  /// Decoration to customize the editor
  final EditorDecoration? decoration;

  final double? minFontSize;
  final double? maxFontSize;
  final double? fontSizedHeight;

  /// Create a [TextEditor] widget
  ///
  /// [fonts] list of font families that you want to use in editor.
  ///
  /// After edit process completed, [onEditCompleted] callback will be called
  /// with new [textStyle], [textAlingment] and [text] value
  TextEditor({
    required this.fonts,
    required this.fontDecoration,
    required this.onEditCompleted,
    this.paletteColors,
    this.backgroundColor,
    this.text = '',
    this.textStyle,
    this.textAlingment,
    this.minFontSize = 1,
    this.maxFontSize = 100,
    this.onTextAlignChanged,
    this.onTextStyleChanged,
    this.onTextChanged,
    this.decoration,
    this.fontSizedHeight = 300,
    this.visibleColorize = true,
    required this.controller,
    this.mentionList,
    this.tagList,
  });

  @override
  _TextEditorState createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  late TextStyleModel _textStyleModel;
  late FontOptionModel _fontOptionModel;
  late Widget _doneButton;

  @override
  void initState() {
    _textStyleModel = TextStyleModel(
      textStyle: widget.textStyle,
      textAlign: widget.textAlingment,
    );
    _fontOptionModel = FontOptionModel(
      _textStyleModel,
      widget.fonts,
      colors: widget.paletteColors,
      visibleColorize: widget.visibleColorize,
    );

    // Rebuild whenever a value changes
    _textStyleModel.addListener(() {
      setState(() {});
    });

    // Rebuild whenever a value changes
    _fontOptionModel.addListener(() {
      setState(() {});
    });

    setState(() {
      widget.controller.text = widget.text;
    });

    // Initialize decorator
    _doneButton = widget.decoration?.doneButton ?? Text('Done', style: TextStyle(color: Colors.white));

    super.initState();
  }

  void _editCompleteHandler() {
    widget.onEditCompleted(
      _textStyleModel.textStyle!,
      _textStyleModel.textAlign!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextEditorData(
      textStyleModel: _textStyleModel,
      fontOptionModel: _fontOptionModel,
      child: Container(
        color: widget.backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => _editCompleteHandler(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: _editCompleteHandler,
                                child: _doneButton,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: TextField(
                                    controller: widget.controller,
                                    onChanged: (value) {
                                      widget.onTextChanged!(value);
                                      setState(() {});
                                    },
                                    maxLines: null,
                                    minLines: null,
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.multiline,
                                    style: _textStyleModel.textStyle,
                                    textAlign: _textStyleModel.textAlign!,
                                    autofocus: true,
                                    cursorColor: Colors.white,
                                  ),
                                ),
                              ),
                              Center(
                                child: FontSize(
                                  minFontSize: widget.minFontSize!,
                                  maxFontSize: widget.maxFontSize!,
                                  fontSizedHeight: widget.fontSizedHeight!,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: widget.decoration?.bottomSettingDecoration,
              padding: EdgeInsets.symmetric(horizontal: widget.mentionList != null && widget.mentionList!.isNotEmpty || widget.tagList != null && widget.tagList!.isNotEmpty ? 0 : 16, vertical: 16),
              child: BackdropFilter(
                filter: widget.decoration?.imageFilter ?? ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.mentionList != null && widget.mentionList!.isNotEmpty || widget.tagList != null && widget.tagList!.isNotEmpty) ...[
                      if (widget.mentionList!.isNotEmpty) Mentions(widget.mentionList!),
                      if (widget.tagList!.isNotEmpty) Tags(widget.tagList!),
                    ] else ...[
                      Row(
                        children: [
                          Row(
                            children: [
                              FontOptionSwitch(
                                fontFamilySwitch: widget.decoration?.fontFamily,
                                colorPaletteSwitch: widget.decoration?.colorPalette,
                              ),
                              SizedBox(width: 16),
                              if (_fontOptionModel.status == FontOptionStatus.fontFamily) ...[
                                TextAlignment(
                                  left: widget.decoration?.alignment?.left,
                                  center: widget.decoration?.alignment?.center,
                                  right: widget.decoration?.alignment?.right,
                                ),
                                SizedBox(width: 16),
                                TextBackgroundColor(
                                  enableWidget: widget.decoration?.textBackground?.enable,
                                  disableWidget: widget.decoration?.textBackground?.disable,
                                ),
                                SizedBox(width: 16),
                              ]
                            ],
                          ),
                          Expanded(child: Align(alignment: Alignment.centerRight, child: _fontOptionModel.status == FontOptionStatus.fontFamily ? FontFamily(_fontOptionModel.fonts, widget.fontDecoration) : ColorPalette(_fontOptionModel.colors!, _fontOptionModel.visibleColorize))),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Decoration to customize text alignment widgets' design.
///
/// Pass your custom widget to `left`, `right` and `center` to customize their design
class AlignmentDecoration {
  /// Left alignment widget
  final Widget? left;

  /// Center alignment widget
  final Widget? center;

  /// Right alignment widget
  final Widget? right;

  AlignmentDecoration({this.left, this.center, this.right});
}

/// Decoration to customize text background widgets' design.
///
/// Pass your custom widget to `enable`, and `disable` to customize their design
class TextBackgroundDecoration {
  /// Enabled text background widget
  final Widget? enable;

  /// Disabled text background widget
  final Widget? disable;

  TextBackgroundDecoration({this.enable, this.disable});
}

/// Decoration to customize the editor
///
/// By using this class, you can customize the text editor's design
class EditorDecoration {
  /// Done button widget
  final Widget? doneButton;
  final AlignmentDecoration? alignment;

  /// Text background widget
  final TextBackgroundDecoration? textBackground;

  /// Font family switch widget
  final Widget? fontFamily;

  /// Color palette switch widget
  final Widget? colorPalette;

  /// Decoration to bottom widget
  final BoxDecoration? bottomSettingDecoration;

  final ImageFilter? imageFilter;

  EditorDecoration({this.doneButton, this.alignment, this.fontFamily, this.colorPalette, this.textBackground, this.bottomSettingDecoration, this.imageFilter});
}

/// Font List widget
class FontDecoration {
  final Size? size;
  final Color? fontColor;
  final Color? fontActiveColor;
  final BorderRadius? radius;

  FontDecoration({this.size, this.fontColor, this.fontActiveColor, this.radius});
}

class MentionList {
  final String? username;
  final String? id;
  final String? picture;
  final String? defaultAssetPicture;
  final Function()? onTap;

  MentionList({this.username, this.id, this.picture, this.defaultAssetPicture, this.onTap});
}

class TagList {
  final String? tag;
  final Function()? onTap;

  TagList({this.tag, this.onTap});
}
