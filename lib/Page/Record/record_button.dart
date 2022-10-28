import 'package:flutter/material.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({
    Key? key,
    required this.isRecording,
  }) : super(key: key);
  final bool isRecording;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 120,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 203, 197, 197),
          borderRadius: BorderRadius.circular(80),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(80),
            ),
            child: Icon(
              isRecording ? Icons.rectangle_rounded : Icons.circle,
              color: Colors.red,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
