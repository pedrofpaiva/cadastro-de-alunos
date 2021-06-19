import 'package:cadastro_de_alunos/DAO/studentDAO.dart';
import 'package:cadastro_de_alunos/model/student.dart';
import 'package:cadastro_de_alunos/shared/menu.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class FormEdit extends StatelessWidget {
  final TextEditingController registrationControle = TextEditingController();
  final TextEditingController nameControle = TextEditingController();
  final TextEditingController emailControle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edição de alunos"),
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
                controller: registrationControle,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Nome do aluno"),
                keyboardType: TextInputType.name,
                controller: nameControle,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Email do aluno"),
                keyboardType: TextInputType.emailAddress,
                controller: emailControle,
              ),
              SizedBox(
                height: 5.0,
              ),
              ElevatedButton(
                child: Text("Salvar"),
                onPressed: () {
                  saveRegister(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveRegister(BuildContext mainContext) async {
    int registration = int.parse(registrationControle.text);
    String name = nameControle.text;
    String email = emailControle.text;
    String message;

    if (!EmailValidator.validate(email)) {
      showDialog(
        context: mainContext,
        builder: (context) => AlertDialog(
          content: Text("Email inválido!!!"),
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
    } else {
      Student student = Student(name: name, email: email, id: registration);
      int resultado = await StudentDAO.updateRecord(
        "students",
        student.toMap(),
      );
      if (resultado != 0) {
        message = "O aluno $name foi atualizado com sucesso!!!";
      } else {
        message = "Não foi possível atualizar o aluno $name!!!";
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
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
