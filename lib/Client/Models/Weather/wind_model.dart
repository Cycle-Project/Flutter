class WindModel {
  double? speed;

  WindModel({this.speed});

  WindModel.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    return data;
  }
}
