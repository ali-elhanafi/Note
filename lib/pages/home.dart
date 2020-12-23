import 'package:flutter/material.dart';
import 'package:note/pages/NoteUpdate.dart';
import 'package:note/pages/newnote.dart';
import 'package:note/pages/noteDetalis.dart';
import '../data_base.dart';
import 'package:note/model/notes.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper helper;
  TextEditingController teSearch = TextEditingController();
  var allNotes = [];
  var items = [];
  @override
  void initState() {
    super.initState();
    helper = DbHelper();
    helper.allNotes().then((notes) {
      setState(() {
        allNotes = notes;
        items = allNotes;
      });
    });
  }

//filter function
  void filterSearch(String query) async {
    var dummySearchList = allNotes;
    if (query.isNotEmpty) {
      var dummyListData = List();
      dummySearchList.forEach((item) {
        var note = Note.fromMap(item);
        //lowercase is better in searsh
        if (note.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items = [];
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items = [];
        items = allNotes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data base'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NewNote()));
              })
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                filterSearch(value);
              });
            },
            controller: teSearch,
            decoration: InputDecoration(
              hintText: 'search...',
              labelText: 'search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28))),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              Note note = Note.fromMap(items[index]);
              return Card(
                margin: EdgeInsets.all(7),
                child: ListTile(
                  title: Text(
                      '${note.name} - ${note.hours} hours- ${note.newField}'),
                  subtitle: Text(note.content),
                  trailing: Column(
                    children: [
                      Expanded(
                        child: IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                helper.delete(note.id);
                              });
                            }),
                      ),
                      Expanded(
                        child: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NoteUpdate(note)));
                            }),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NoteDetails())),
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
// body: FutureBuilder(
//   future: helper.allNotes(),
//   builder: (context, AsyncSnapshot snapshot) {
//     if (!snapshot.hasData) {
//       return Center(child: CircularProgressIndicator());
//     } else {
//       return ;
//     }
//   },
// ),
