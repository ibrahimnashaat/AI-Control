class TranslationModel {
  late String categories;

  TranslationModel.fromJson(Map<String, dynamic> json) {
    categories = json['categories'];
  }
}