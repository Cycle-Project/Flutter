class ElevationModel {
  double? elevation;

  ElevationModel({this.elevation});

  ElevationModel.fromJson(Map<String, dynamic> json) {
    elevation = json['elevation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['elevation'] = elevation;
    return data;
  }
}