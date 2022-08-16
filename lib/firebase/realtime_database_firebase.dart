import 'package:firebase_database/firebase_database.dart';

class RealDB {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference? databaseReferencec;
  
  void creatDB(String task)
  {
    databaseReferencec = firebaseDatabase.ref();
    databaseReferencec!.child("Task").push().set({"task":"$task"});
  }
  
  Stream<DatabaseEvent> getData()
  {
    databaseReferencec =firebaseDatabase.ref();
    return databaseReferencec!.child("Task").onValue;
  }
  
}
