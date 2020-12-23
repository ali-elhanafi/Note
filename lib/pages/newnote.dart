import 'package:flutter/material.dart';
import 'package:note/model/notes.dart';

import 'package:note/data_base.dart';

class NewNote extends StatefulWidget {
  NewNote({Key key}) : super(key: key);

  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  String name;
  String content;
  int hours;
  //extract opject
  DbHelper helper;
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('new note'),
      ),
      body: SafeArea(
        
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            
            padding: EdgeInsets.all(12.0),
            child: Form(
              
              child: ListView(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'enter note name',
                    ),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'enter note content',
                    ),
                    onChanged: (value) {
                      content = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'enter note date',
                    ),
                    onChanged: (value) {
                      hours = int.parse(value);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                      child: Text('save'),
                      onPressed: () async {
                        var note = Note(
                            {'name': name, 'content': content, 'hours': hours});
                        int id = await helper.createNote(note);
                        print(id);
                        Navigator.of(context).pop();
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
