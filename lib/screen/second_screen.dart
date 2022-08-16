import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_keeper/firebase/realtime_database_firebase.dart';
import 'package:note_keeper/model/modeldata.dart';
import 'package:note_keeper/sqldatabase/sqlDatabase.dart';

class Second_Screen extends StatefulWidget {
  const Second_Screen({Key? key}) : super(key: key);

  @override
  State<Second_Screen> createState() => _Second_ScreenState();
}

class _Second_ScreenState extends State<Second_Screen> {
  TextEditingController write_note = TextEditingController();

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Crate Task"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: write_note,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.note),
                  labelText: "Write Note",
                  border: OutlineInputBorder(),
                ),
                maxLength: 40,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        setState((){
                          DBHalper().insertData(write_note.text,0);
                        });
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: Text("Crate"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
