import 'package:flutter/material.dart';

class myToDo extends StatefulWidget{

  @override
  State<myToDo> createState() => _myToDoState();
}

class _myToDoState extends State<myToDo> {
  @override
  var textToDo = TextEditingController();
  var result = '';
  var toDoList = <Map<String, dynamic>>[];

  void handleAdd(String text) {
    setState(() {
      toDoList.add(
          {
            "text" : text,
            "status" : false
          }
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MyToDo"),
          leading: Icon(Icons.check_box),
        ),

        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for(int i = 0; i < toDoList.length ; ++i)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)
                      ),
                      child: Container(
                        height: 60.0,
                        child: Row(
                          children: [
                            Checkbox(
                              value: toDoList[i]['status'], // กำหนดสถานะปัจจุบันให้กับ Checkbox
                              onChanged: (bool? value) {
                                // onChanged จะทำงานเมื่อมีการเปลี่ยนสถานะของ Checkbox
                                // โดยสถานะใหม่จะถูกส่งมาที่พารามิเตอร์ value
                                setState(() {
                                  toDoList[i]['status'] = value;
                                });
                              },
                            ),
                            (toDoList[i]['status']
                                ? Text("${toDoList[i]['text']}",style: TextStyle(decoration: TextDecoration.lineThrough))
                                :Text("${toDoList[i]['text']}",style: TextStyle(decoration: TextDecoration.none))),
                            Expanded(child: SizedBox.shrink()),

                            IconButton(onPressed: () {
                              setState(() {
                                toDoList.removeAt(i);
                              });
                            }, icon: Icon(Icons.delete))
                          ],
                        ),
                      ),
                    ),
                  ),

                const Expanded(child: SizedBox.shrink()),
                Card(
                  elevation: 3.0,
                  child: Container(
                    height: 80.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: textToDo,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter new ToDo'
                              ),
                            ),
                          ),
                          TextButton(onPressed: (){
                            handleAdd(textToDo.text);
                            textToDo.clear();
                          }, child: Text("ADD"))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}