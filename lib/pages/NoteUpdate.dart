import 'package:flutter/material.dart';
import 'package:note/data_base.dart';
import 'package:note/model/notes.dart';

class NoteUpdate extends StatefulWidget {
  Note note;
  NoteUpdate(this.note);
  //NoteUpdate({Key key}) : super(key: key);

  @override
  _NoteUpdateState createState() => _NoteUpdateState();
}

class _NoteUpdateState extends State<NoteUpdate> {
  TextEditingController teName = TextEditingController();
  TextEditingController teContent = TextEditingController();
  TextEditingController teHours = TextEditingController();
  TextEditingController teNewField = TextEditingController();
  DbHelper helper;
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    teName.text = widget.note.name;
    teContent.text = widget.note.content;
    teHours.text = widget.note.hours.toString();
    teNewField.text = widget.note.newField.toString();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Note'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextField(
              controller: teName,
            ),
            TextField(
              maxLines: null,
              controller: teContent,
            ),
            TextField(
              controller: teHours,
            ),
             TextField(
              controller: teNewField,
            ),
            RaisedButton(
                child: Text('save'),
                onPressed: () {
                  var updateNote = Note({
                    'id': widget.note.id,
                    'name': teName.text,
                    'content': teContent.text,
                    'hours': int.parse(teHours.text),
                    'newField': int.parse(teNewField.text)

                  });
                  helper.noteUpdate(updateNote);
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }
}
