class GMElevation {
  double? elevation;

  GMElevation({this.elevation});

  GMElevation.fromJson(Map<String, dynamic> json) {
    elevation = json['elevation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['elevation'] = elevation;
    return data;
  }
}
