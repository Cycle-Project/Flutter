import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomDialog extends HookWidget {
  const CustomDialog({
    Key? key,
    required this.message,
    required this.icon,
    required this.color,
    this.onEnd,
    this.actionsPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.actions,
  }) : super(key: key);

  final String message;
  final IconData icon;
  final Color color;
  final Function()? onEnd;
  final List<Widget>? actions;
  final EdgeInsets actionsPadding;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      return () {
        if (onEnd != null) onEnd!();
      };
    }, []);
    return Dialog(
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.only(top: 30),
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .5,
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (actions != null)
                  Padding(
                    padding: actionsPadding,
                    child: Column(
                      children: actions!,
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            top: -30,
            left: 0,
            right: 0,
            child: Center(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  margin: const EdgeInsets.all(3),
                  padding: const EdgeInsets.all(3),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DialogButton extends StatelessWidget {
  const DialogButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.color,
    this.height = 60,
    this.textColor = Colors.white,
  }) : super(key: key);

  final String text;
  final Color color;
  final double height;
  final Color textColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

showSuccessDialog(context, message) async {
  Timer timer = Timer(
    const Duration(seconds: 1),
    () => Navigator.of(context).pop(true),
  );
  return await showDialog(
    context: context,
    builder: (_) => CustomDialog(
      message: message,
      icon: Icons.done,
      color: Colors.green,
      onEnd: () => timer.cancel(),
    ),
  );
}

showFailDialog(context, message) async {
  Timer timer = Timer(
    const Duration(seconds: 1),
    () => Navigator.of(context).pop(false),
  );
  return await showDialog(
    context: context,
    builder: (_) => CustomDialog(
      message: message,
      icon: Icons.close,
      color: Colors.red,
      onEnd: () => timer.cancel(),
    ),
  );
}

Future<bool> showQuestionDialog(context, question) async => await showDialog(
      context: context,
      builder: (_) => CustomDialog(
        message: question,
        icon: Icons.question_mark_rounded,
        color: Colors.blueAccent,
        actions: [
          const SizedBox(height: 4),
          DialogButton(
            onTap: () => Navigator.of(context).pop(true),
            text: "Approve",
            height: 56,
            color: Colors.blueAccent,
          ),
          DialogButton(
            onTap: () => Navigator.of(context).pop(false),
            text: "Cancel",
            height: 48,
            color: Colors.transparent,
            textColor: Colors.grey[800]!,
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
