import 'package:flutter/material.dart';
import 'package:geo_app/components/special_card.dart';

class RecordRoute extends StatelessWidget {
  const RecordRoute({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpecialCard(
      backgroundColor: Colors.red,
      shadowColor: Colors.transparent,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.circle,
                  size: 20,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Text(
                "Record My Route",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}