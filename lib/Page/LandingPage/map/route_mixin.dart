// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geo_app/Client/Controller/route_controller.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Page/Enterance/enterance_page.dart';
import 'package:geo_app/Page/utilities/crypt.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:geo_app/main.dart';
import 'package:geo_app/Client/Models/Route/route.dart' as r;

mixin RouteMixin {
  static const String routeTag = "Cdmg+lfdsaFDdsafDShYJyuı4AFD";
  static final RouteController _routeController = RouteController();
  final Cryption _cryption = Cryption();

  Future<List<r.Route>> getRoutesOf(context, String id) async {
    if (applicationUserModel.id == null) {
      await showFailDialog(context, "You must Register/Login to see!");
      return [];
    }
    return await _routeController.getRoutesOf(
        id: id, token: applicationUserModel.token!);
  }

  save(context, r.Route route) async {
    if (applicationUserModel.id == null) {
      _saveForNonsignedUsers(context, route);
    } else {
      _saveToDb(context, route);
    }
  }

  saveFromMemory(context) async {
    String? encrypted = await CacheManager.getSharedPref(tag: routeTag);
    if (encrypted == null) return;
    String value = _cryption.decrypt(encrypted);
    r.Route route = r.Route.fromJson(json.decode(value));
    await _saveToDb(context, route);
    await CacheManager.remove(tag: routeTag);
  }

  share(context, r.Route newRoute) {
    /// TODO Share
  }
  _saveToDb(context, r.Route route) async {
    r.Route newRoute = await _routeController.createRoute(
      route.toJson(),
      token: applicationUserModel.token!,
    );
    if (newRoute.id != null) {
      await showSuccessDialog(
        context,
        'Route created!',
        delay: false,
        actions: [
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'Would you like to share this Route?',
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 4),
          DialogButton(
            onTap: () => share(context, newRoute),
            text: "Share",
            height: 56,
            color: Colors.lightGreen[800]!,
          ),
          DialogButton(
            onTap: () => Navigator.of(context).pop(false),
            text: "Keep Private",
            height: 48,
            color: Colors.transparent,
            textColor: Colors.grey[800]!,
          ),
          const SizedBox(height: 4),
        ],
      );
    } else {
      await showFailDialog(
          context, 'Failed to create route!\nPlease try again');
    }
  }

  _saveForNonsignedUsers(context, r.Route route) async {
    String? shared = await CacheManager.getSharedPref(tag: routeTag);
    if (shared != null) {
      bool isGoingToLogin = await showQuestionDialog(
          context, 'You need to login to save more than 1 route!');
      if (isGoingToLogin) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => EnterancePage(),
          ),
          (route) => false,
        );
      }
      return;
    }
    String value = route.toJson().toString();
    String encrypted = _cryption.encrypt(value);
    await CacheManager.saveSharedPref(tag: routeTag, value: encrypted);
    await showSuccessDialog(
      context,
      'Your route has been saved to memory!\n'
      'If you want to:\n '
      '\t- Save more Routes\n'
      '\t- Access routes from eveywhere\n'
      'You need to Join the Community by Register/Login',
      delay: false,
    );
  }
}
