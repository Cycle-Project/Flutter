// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geo_app/Client/Controller/route_controller.dart';
import 'package:geo_app/Client/Manager/cache_manager.dart';
import 'package:geo_app/Client/Models/Route/position.dart';
import 'package:geo_app/Page/Enterance/enterance_page.dart';
import 'package:geo_app/Page/LandingPage/Share/share_route_page.dart';
import 'package:geo_app/Page/LandingPage/map/provider/map_provider.dart';
import 'package:geo_app/Page/LandingPage/map/provider/plan_route_provider.dart';
import 'package:geo_app/Page/utilities/crypt.dart';
import 'package:geo_app/Page/utilities/dialogs.dart';
import 'package:geo_app/main.dart';
import 'package:geo_app/Client/Models/Route/route.dart' as r;
import 'package:provider/provider.dart';

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

  save(context, {required MapsProvider mapsProvider}) async {
    if (applicationUserModel.id == null) {
      _saveForNonsignedUsers(
        context,
        mapsProvider.polylineCoordinates
            .map((e) => Position.fromLatLng(e))
            .toList(),
      );
    } else {
      _saveToDb(context, {
        "positions": mapsProvider.polylineCoordinates
            .map((e) => Position.fromLatLng(e))
            .toList(),
        "userMadeId": applicationUserModel.id,
      });
    }
  }

  _saveForNonsignedUsers(context, List<Position> list) async {
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
    String value = list.toString();
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

  saveFromMemory(context) async {
    String? encrypted = await CacheManager.getSharedPref(tag: routeTag);
    if (encrypted == null) return;
    String value = _cryption.decrypt(encrypted);
    Map map = json.decode(value);
    await _saveToDb(context, map);
    await CacheManager.remove(tag: routeTag);
  }

  _saveToDb(context, map) async {
    r.Route newRoute = await _routeController.createRoute(
      map,
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
            onTap: () => sharePage(context, newRoute),
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

  sharePage(context, route) => showDialog(
        context: context,
        builder: (_) => MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
              value: Provider.of<MapsProvider>(context),
            ),
            ChangeNotifierProvider.value(
              value: Provider.of<PlanRouteProvider>(context),
            ),
          ],
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(16),
            child: ShareRoutePage(route: route),
          ),
        ),
      );
}
