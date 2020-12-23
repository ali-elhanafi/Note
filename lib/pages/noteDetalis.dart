import 'package:flutter/material.dart';
import 'package:note/model/notes.dart';

class NoteDetails extends StatelessWidget {
  Note note;
  NoteDetails({this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detailes'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              note.name,
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              note.content,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            SizedBox(
              height: 20,
            ),
            Text(note.hours.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}
