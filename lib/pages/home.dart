// import 'package:flutter/material.dart';
// import 'package:todolist/constrant/colors.dart';
// import 'package:todolist/model/todo.dart';
// import 'package:todolist/widget/todolist.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final todosList = ToDo.todoList();
//   final _todoController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: tdBGColor,
//       appBar: _appBar(),
//       body: Stack(
//         children: [
//           Container(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//               child: Column(children: [
//                 SearchBox(),
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       Container(
//                         height: 40,
//                         margin: EdgeInsets.only(top: 50, bottom: 20),
//                         child: Text(
//                           "To Do List",
//                           style: TextStyle(
//                               fontSize: 30, fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                       for (ToDo toDo in todosList)
//                         ToDoList(
//                             todo: toDo,
//                             onToDoChanged: _handleToDoChange,
//                             onDeleteItem: _deleteToDoItem),
//                     ],
//                   ),
//                 )
//               ]),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: TextField(
//                         decoration: InputDecoration(
//                             hintText: 'Add a new todo list',
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.symmetric(
//                                 vertical: 25, horizontal: 20))),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(right: 20, bottom: 20),
//                   decoration: BoxDecoration(),
//                   child: ElevatedButton(
//                       onPressed: () {
//                         _addToDoItem(_todoController.text);
//                       },
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: tdBlue, minimumSize: Size(60, 60)),
//                       child: Icon(Icons.add)),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   void _addToDoItem(String toDo) {
//     setState(() {
//       todosList.add(ToDo(
//           id: DateTime.now().millisecondsSinceEpoch.toString(),
//           todoText: toDo));
//     });
//     _todoController.clear();
//   }

//   void _handleToDoChange(ToDo todo) {
//     setState(() {
//       todo.isDone = !todo.isDone;
//     });
//   }

//   void _deleteToDoItem(String id) {
//     setState(() {
//       todosList.removeWhere((item) => item.id == id);
//     });
//   }

//   Widget SearchBox() {
//     return Container(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         child: TextField(
//           decoration: InputDecoration(
//               prefixIcon: Icon(
//                 Icons.search,
//                 color: tdBlack,
//               ),
//               prefixIconConstraints:
//                   BoxConstraints(maxHeight: 20, minWidth: 25),
//               border: InputBorder.none,
//               hintText: 'Search',
//               hintStyle: TextStyle(color: tdGrey)),
//         ),
//       ),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(20)),
//     );
//   }

//   AppBar _appBar() {
//     return AppBar(
//       backgroundColor: tdBGColor,
//       elevation: 0,
//       leading: Icon(
//         Icons.menu,
//         color: tdBlack,
//       ),
//       actions: [
//         Icon(
//           Icons.person,
//           size: 27,
//           color: tdBlack,
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:todolist/constrant/colors.dart';
import 'package:todolist/widget/todolist.dart';

import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 50,
                          bottom: 20,
                        ),
                        child: Text(
                          'All ToDos',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      for (ToDo todoo in _foundToDo.reversed)
                        ToDoList(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 20,
                  right: 20,
                ),
                child: ElevatedButton(
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: toDo,
      ));
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ]),
    );
  }
}
