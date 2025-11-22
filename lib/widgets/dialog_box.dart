import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final String text;
  final Function() onSave;
  final Controller;
  const DialogBox({
    super.key,
    required this.onSave,
    required this.text,
    required this.Controller,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.tealAccent,
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: Controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Add a new task',
              ),
            ),
            ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
