import 'package:flutter/material.dart';

class PlanButton extends StatelessWidget {
  const PlanButton({
    Key? key,
    required this.isOpen,
  }) : super(key: key);
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isOpen ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(isOpen ? 15 : 10),
              child: Icon(
                Icons.route,
                size: isOpen ? 35 : 20,
                color: Colors.blue,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  "Plan",
                  style: TextStyle(
                    fontSize: 20,
                    color: isOpen ? Colors.blue : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
