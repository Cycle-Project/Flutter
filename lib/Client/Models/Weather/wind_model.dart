//
//  user_model.dart
//  Flutter
//
//  Created by Ömer Faruk Öztürk on 29.12.2022.
//

class WindModel {
  double? speed;

  WindModel({
    this.speed,
  });

  WindModel.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'speed': speed,
  };
}
