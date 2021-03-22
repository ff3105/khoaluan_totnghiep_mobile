import 'package:flutter/material.dart';

class DialogLoading {
  BuildContext _context;

  factory DialogLoading.of(BuildContext context) {
    return DialogLoading._create(context);
  }

  DialogLoading._create(this._context);

  void show() {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) {
          return _loading();
        });
  }

  void hide() {
    Navigator.pop(_context);
  }

  Widget _loading() {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: const [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}