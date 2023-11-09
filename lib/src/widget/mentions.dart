import 'package:flutter/material.dart';
import 'package:text_editor/text_editor.dart';

class Mentions extends StatefulWidget {
  final List<MentionList> mentions;

  Mentions(this.mentions);

  @override
  _MentionsState createState() => _MentionsState();
}

class _MentionsState extends State<Mentions> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...widget.mentions.map((m) {
              final last = m == widget.mentions.first;
              return _Mention(m, last);
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class _Mention extends StatelessWidget {
  final MentionList mention;
  final bool isLastItem;

  _Mention(this.mention, this.isLastItem);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => mention.onTap!(),
      child: Container(
        width: 58,
        margin: EdgeInsets.only(right: 10, left: isLastItem ? 10 : 0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(48),
              child: mention.picture != null
                  ? Image.network(
                      mention.picture ?? "",
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    )
                  : mention.defaultAssetPicture != null
                      ? Image.asset(mention.defaultAssetPicture!)
                      : Container(
                          color: Colors.white,
                          width: 48,
                          height: 48,
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.purple[900],
                              size: 30,
                            ),
                          ),
                        ),
            ),
            SizedBox(height: 6),
            Text(
              mention.username!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
