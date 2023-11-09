import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

class Tags extends StatefulWidget {
  final List<TagList> tags;

  Tags(this.tags);

  @override
  _MentionsState createState() => _MentionsState();
}

class _MentionsState extends State<Tags> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...widget.tags.map((t) {
              final last = t == widget.tags.first;
              return _Tag(t, last);
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final TagList tag;
  final bool isLastItem;

  _Tag(this.tag, this.isLastItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tag.onTap!(),
      child: Container(
        height: 26,
        padding: EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        margin: EdgeInsets.only(right: 10, left: isLastItem ? 10 : 0),
        child: Center(
          child: Text(
            tag.tag ?? "",
            style: TextStyle(fontSize: 13, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
