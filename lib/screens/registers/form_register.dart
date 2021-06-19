import 'package:cadastro_de_alunos/DAO/studentDAO.dart';
import 'package:cadastro_de_alunos/model/student.dart';
import 'package:cadastro_de_alunos/shared/menu.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class FormRegister extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de alunos"),
      ),
      drawer: Menu(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Nome do aluno"),
                keyboardType: TextInputType.name,
                controller: nameController,
              ),
              SizedBox(
                height: 5.0,
              ),
              TextField(
                decoration: InputDecoration(labelText: "Email do aluno"),
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              SizedBox(
                height: 5.0,
              ),
              ElevatedButton(
                child: Text("Cadastrar aluno"),
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
    String name = nameController.text;
    String email = emailController.text;
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
      Student student = Student(
        name: name,
        email: email,
      );
      int resultado = await StudentDAO.insertRecord(
        "students",
        student.toMap(),
      );
      if (resultado != 0) {
        message = "O aluno $name foi cadastrado com sucesso!!!";
      } else {
        message = "Não foi possível cadastrar o aluno $name!!!";
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
}
