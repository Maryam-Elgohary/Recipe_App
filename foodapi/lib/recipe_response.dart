import 'package:foodapi/recipe_details.dart';

class RecipeResponse {
  late List<RecipeDetails>? results;
  late int? offset;
  late int? number;
  late int? totalResults;

  RecipeResponse({
    required this.results,
    required this.offset,
    required this.number,
    required this.totalResults,
  });

  RecipeResponse.fromMap(Map<String, dynamic> map) {
    this.offset = map['offset'];
    this.number = map['number'];
    this.totalResults = map['totalResults'];
    this.results = [];

    ((map['results'] ?? []) as List<dynamic>).forEach((element) {
      this.results!.add(RecipeDetails.fromMap(element));
    });
  }
  Map<String, dynamic> toMap() {
    List<Map> tmpList = [];
    this.results!.forEach((element) {
      tmpList.add(element.toMap());
    });
    Map<String, dynamic> map = {
      "offset": this.offset,
      "number": this.number,
      "totalResults": this.totalResults,
      "results": tmpList,
    };
    return map;
  }
}
