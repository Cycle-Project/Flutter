import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/components/header.dart';
import 'package:intl/intl.dart';

class UserProgress extends HookWidget {
  const UserProgress({
    super.key,
    required this.progressOfKms,
  });

  final double progressOfKms;

  getProgressByUnit(Unit unit) {
    var f = NumberFormat("###,###,###,###,###,###.0#", "en_US");
    double value = progressOfKms * (unit == Unit.kiloMeters ? 1 : 0.6213711922);
    return f.format(value);
  }

  @override
  Widget build(BuildContext context) {
    final unit = useState(Unit.kiloMeters);
    return GestureDetector(
      onTap: () =>
          unit.value = unit.value == Unit.miles ? Unit.kiloMeters : Unit.miles,
      child: Stack(
        children: [
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Header(title: "You made", color: Colors.white),
                const SizedBox(height: 4),
                Text(
                  getProgressByUnit(unit.value).toString(),
                  style: const TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      unit.value == Unit.kiloMeters ? "Kilometers" : "Miles",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_outlined,
                      size: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum Unit { kiloMeters, miles }
