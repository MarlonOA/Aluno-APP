import 'package:flutter/material.dart';

class TelaSobre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre os Desenvolvedores"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Desenvolvedor: Marlon Oliveira Augusto",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("E-mail: marlon@gmail.com"),
            Text("GitHub: github.com/MarlonOliveira"),
            SizedBox(height: 16),
            Text(
              "Desenvolvedor: Bruno William Silva",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("E-mail: bruno@gmail.com"),
            Text("GitHub: github.com/BrunoWilliam"),
          ],
        ),
      ),
    );
  }
}
