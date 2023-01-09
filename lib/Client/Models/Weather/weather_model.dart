class WeatherModel {
  String? main;
  String? description;
  String? icon;

  WeatherModel({
    this.main,
    this.description,
    this.icon,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}
