import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, "/");
              },
              icon: Icon(Icons.group),
              label: Text(
                "Listar alunos",
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/insert", (route) => false);
              },
              icon: Icon(Icons.add),
              label: Text(
                "Cadastrar aluno",
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/edit", (route) => false);
              },
              icon: Icon(Icons.edit),
              label: Text(
                "Atualizar dados",
              ),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/remove", (route) => false);
              },
              icon: Icon(Icons.delete),
              label: Text(
                "Remover aluno",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
