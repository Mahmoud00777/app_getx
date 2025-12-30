class CompanyListModel {
  List<String>? data;

  CompanyListModel({this.data});

  CompanyListModel.fromJson(Map<String, dynamic> json) {
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    return data;
  }
}
