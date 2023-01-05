import 'package:flutter/material.dart';

showSuccessDialog(context, message) async => await showDialog(
      context: context,
      builder: (_) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          title: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(Icons.done, color: Colors.white, size: 32),
              ),
              const Expanded(
                child: Text(
                  "Success",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * .5,
            ),
            child: SingleChildScrollView(
              child: Text(message, textAlign: TextAlign.center),
            ),
          ),
        );
      },
    );

showFailDialog(context, message) async => await showDialog(
      context: context,
      builder: (_) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
          title: Row(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.error, color: Colors.red, size: 32),
              ),
              Expanded(
                child: Text(
                  "Fail",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * .5,
            ),
            child: SingleChildScrollView(
              child: Text(message, textAlign: TextAlign.center),
            ),
          ),
        );
      },
    );
