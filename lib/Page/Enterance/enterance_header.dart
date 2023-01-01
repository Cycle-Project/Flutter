import 'package:flutter/material.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class EnteranceHeader extends StatelessWidget {
  const EnteranceHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
      child: SizedBox(
        height: 60,
        child: Row(
          children: const [
            Expanded(
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                    color: Constants.primaryColor,
                  ),
                  child: SizedBox(
                    width: 60,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "Cy",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  " Cycleon",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
