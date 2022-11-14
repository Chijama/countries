import 'package:flutter/material.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: new Icon(Icons.photo),
          title: new Text('Photo'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: new Icon(Icons.music_note),
          title: new Text('Music'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: new Icon(Icons.videocam),
          title: new Text('Video'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: new Icon(Icons.share),
          title: new Text('Share'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}