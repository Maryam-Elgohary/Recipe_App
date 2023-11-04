import 'dart:convert';

import 'package:foodapi/recipe_info.dart';
import 'package:foodapi/recipe_response.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<RecipeResponse> getData() async {
    final http.Response response = await http.get(Uri.parse(
        "https://api.spoonacular.com/recipes/complexSearch?apiKey=beea43a5326b4785931d55b83cdfaff1"));
    if (response.statusCode <= 299 && response.statusCode >= 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      RecipeResponse recipeResponse = RecipeResponse.fromMap(body);
      //print(body);
      return recipeResponse;
    } else {
      throw ('failed' + response.body);
    }
  }

  Future<RecipesInfo> getDataDetails(int? id) async {
    final http.Response response = await http.get(Uri.parse(
        "https://api.spoonacular.com/recipes/$id/information?apiKey=beea43a5326b4785931d55b83cdfaff1"));
    if (response.statusCode <= 299 && response.statusCode >= 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      RecipesInfo description = RecipesInfo.fromMap(body);

      return description;
    } else {
      throw ('failed${response.body}');
    }
  }
}
