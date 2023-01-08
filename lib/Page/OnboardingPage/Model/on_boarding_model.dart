import 'package:flutter/material.dart';

class OnboardingModel {
  final String lottie;
  final String title;
  final String subtitle;
  final int counter;
  final Color bgColor;

  OnboardingModel({
    required this.lottie,
    required this.title,
    required this.subtitle,
    required this.counter,
    required this.bgColor,
  });
}
