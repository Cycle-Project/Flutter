import 'package:geo_app/Client/Models/Route/position.dart';

class Route {
  String? id;
  List<Position>? positions;
  String? userMadeId;

  Route({this.id, this.positions, this.userMadeId});

  Route.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['positions'] != null) {
      positions = <Position>[];
      json['positions'].forEach((v) {
        positions!.add(Position.fromJson(v));
      });
    }
    userMadeId = json['userMadeId'];
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'positions': positions?.map((v) => v.toJson()).toList() ?? [],
        'userMadeId': userMadeId,
      };
}
