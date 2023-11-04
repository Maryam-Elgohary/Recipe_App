import 'package:foodapi/recipe_details.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String title = 'title';
final String id = 'id';
final String image = 'image';
final String imageType = 'imageType';
final String isFavorite = 'isFavorite';

class RecipeHelper {
  late Database db;
  static final RecipeHelper instance = RecipeHelper._internal();

  factory RecipeHelper() {
    return instance;
  }
  RecipeHelper._internal();

  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'recipe.db'),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
create table RecipeTable ( 
  $id integer ,
  $title text not null,
  $image text not null,
  $imageType text not null,
  $isFavorite integer
  )
''');
    });
  }

  Future<List<RecipeDetails>> getFavRecipes() async {
    List<Map<String, dynamic>> maps = await db.query('RecipeTable');
    if (maps.isEmpty)
      return [];
    else {
      List<RecipeDetails> recipe = [];
      maps.forEach((element) {
        recipe.add(RecipeDetails.fromMap(element as Map<String, dynamic>));
      });
      print(maps);
      return recipe;
    }
  }

  Future<RecipeDetails> insert(RecipeDetails recipeDetails) async {
    recipeDetails.id = await db.insert('RecipeTable', recipeDetails.toMap());
    return recipeDetails;
  }

  Future<int> delete(int? id) async {
    return await db.delete('RecipeTable', where: '$id = ?', whereArgs: [id]);
  }

  Future close() async => db.close();
}
