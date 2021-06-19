import 'package:cadastro_de_alunos/DAO/studentDAO.dart';
import 'package:cadastro_de_alunos/model/student.dart';
import 'package:cadastro_de_alunos/shared/menu.dart';
import 'package:flutter/material.dart';

class FormRemove extends StatelessWidget {
  final TextEditingController registrationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Remoção de alunos"),
      ),
      drawer: Menu(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Matrícula do aluno"),
                keyboardType: TextInputType.number,
                controller: registrationController,
              ),
              SizedBox(
                height: 5.0,
              ),
              ElevatedButton(
                child: Text("Remover aluno"),
                onPressed: () {
                  remove(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void remove(BuildContext mainContext) async {
    int registration = int.parse(registrationController.text);
    String message;

    Student student = Student(id: registration);
    int result = await StudentDAO.removeRecord(
      "students",
      student.toMap(),
    );
    if (result != 0) {
      message = "O aluno removido com sucesso!!!";
    } else {
      message = "Não foi possível remover o aluno!!!";
    }
    showDialog(
      context: mainContext,
      builder: (context) => AlertDialog(
        content: Text(message),
        title: Text("Mensagem do sistema"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"))
        ],
      ),
    );
  }
}
