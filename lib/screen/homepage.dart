import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_keeper/sqldatabase/sqlDatabase.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var date = DateFormat.yMMMMEEEEd().format(DateTime.now());

  List note = [];
  int completed = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    readData();
  }

  void readData() async {
    note = await DBHalper().readData();
    for(var x in note)
      {
        if(x["read"]==1)
          {
            completed++;
            print(completed);
          }
      }
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${note.length}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              "$completed",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Created Task",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            Text(
                              "Completed Task",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView.builder(
                    itemCount: note.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 60,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: () async{
                                  int read = note[index]["read"];
                                  read++;
                                  DBHalper().completedRead(note[index]["id"],read%2);
                                  List l1 = await DBHalper().readData();
                                  if(note[index]["read"]%2 == 0)
                                    {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You completed this task !!")));
                                    }
                                  setState(() {
                                    note = l1;
                                    (note[index]["read"]%2 == 0)?completed--:completed++;
                                  });
                                },
                                icon: (note[index]["read"]%2 == 1)
                                    ? Icon(
                                        Icons.check_circle,
                                        size: 35,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.circle_outlined,
                                        size: 35,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${note[index]["note"]}",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color:(note[index]["read"]%2 == 1) ?Colors.grey.shade400:Colors.grey.shade700),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: (){
                                  setDialoge(index);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 35,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                onPressed: ()async{
                                  DBHalper().deleteData(note[index]["id"]);
                                  List l1  = await DBHalper().readData();
                                  setState(() {
                                    note =l1;
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 35,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              // StreamBuilder(
              //   stream: RealDB().getData(),
              //   builder: (context, AsyncSnapshot snapshot) {
              //     if (snapshot.hasError) {
              //       return Center(child: Text("${snapshot.error}"));
              //     } else if (snapshot.hasData) {
              //       return Expanded(
              //         child: ListView.builder(
              //             itemCount: allTask.length,
              //             itemBuilder: (context, index) {
              //               return Container(
              //                 height: 60,
              //                 width: double.infinity,
              //                 margin: EdgeInsets.only(top: 10, bottom: 10),
              //                 child: Row(
              //                   children: [
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: IconButton(
              //                         onPressed: () {
              //                           setState(() {
              //                             completed++;
              //                           });
              //                         },
              //                         icon: (completed % 2 == 1)
              //                             ? Icon(
              //                                 Icons.check_circle,
              //                                 size: 35,
              //                                 color: Colors.green,
              //                               )
              //                             : Icon(
              //                                 Icons.circle_outlined,
              //                                 size: 35,
              //                                 color: Colors.grey,
              //                               ),
              //                       ),
              //                     ),
              //                     Expanded(
              //                       child: Text(
              //                         "${allTask[index].note}",
              //                         style: TextStyle(
              //                             fontSize: 22,
              //                             fontWeight: FontWeight.bold,
              //                             color: Colors.grey.shade700),
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Icon(
              //                         Icons.edit,
              //                         size: 35,
              //                         color: Colors.grey,
              //                       ),
              //                     ),
              //                     Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Icon(
              //                         Icons.delete,
              //                         size: 35,
              //                         color: Colors.grey,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               );
              //             }),
              //       );
              //     } else {
              //       return Center(child: CircularProgressIndicator());
              //     }
              //   },
              // ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'second');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }


  void setDialoge(int i)
  {
    showDialog(context: context, builder: (context){
      TextEditingController write = TextEditingController();
      write.text = note[i]["note"];

      return SimpleDialog(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: write,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.note),
                    labelText: "Write Note",
                    border: OutlineInputBorder(),
                  ),
                  maxLength: 40,
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
                            DBHalper().updateData(note[i]["id"],write.text,0);
                          });
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: Text("Create"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
