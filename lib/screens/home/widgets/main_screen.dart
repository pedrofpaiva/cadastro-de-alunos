import 'package:cadastro_de_alunos/model/student.dart';
import 'package:cadastro_de_alunos/shared/menu.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  final dynamic _data;
  late List<Student> _students;

  MainScreen(this._data);

  @override
  Widget build(BuildContext context) {
    _students = prepareStudents(this._data);
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus alunos"),
      ),
      drawer: Menu(),
      body: ListView.builder(
        itemBuilder: listBuilder,
        itemCount: this._students.length,
      ),
    );
  }

  Widget listBuilder(BuildContext context, int index) {
    return ListTile(
      leading: Icon(Icons.account_box),
      title: Text(
        this._students.elementAt(index).name!,
      ),
      subtitle: Text(
        this._students.elementAt(index).email!,
      ),
    );
  }

  List<Student> prepareStudents(dynamic data) {
    List<Student> students = [];
    for (var map in data) {
      students.add(
        Student.fromMap(map),
      );
    }
    return students;
  }
}
