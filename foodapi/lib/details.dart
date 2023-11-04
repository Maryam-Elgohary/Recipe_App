import 'package:flutter/material.dart';
import 'package:foodapi/api.dart';
import 'package:foodapi/helper.dart';
import 'package:foodapi/recipe_details.dart';
import 'package:foodapi/recipe_info.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsScreen extends StatefulWidget {
  final int? id;
  final String? title;
  final String? image;
  final String? imageType;
  const DetailsScreen(this.id, this.image, this.title, this.imageType,
      {super.key});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late RecipeDetails recipeDetails;
  bool isFavourite = false;
  Color _favIconColor = Colors.black;
  void isFavoritePressed() {
    isFavourite = !isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            color: _favIconColor,
            icon: const Icon(
              Icons.favorite_border,
            ),
            onPressed: () async {
              isFavoritePressed();
              setState(() {
                if (_favIconColor == Colors.black) {
                  _favIconColor = Colors.red;
                } else {
                  _favIconColor = Colors.black;
                }
              });
              print("is favourite");
              await RecipeHelper.instance.insert(RecipeDetails(
                  id: widget.id,
                  title: widget.title,
                  image: widget.image,
                  imageType: widget.imageType));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.play_arrow_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<RecipesInfo>(
            future: Api().getDataDetails(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
              }
              if (snapshot.hasData) {
                return Column(children: [
                  Image.network(snapshot.data!.image.toString()),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          snapshot.data!.title.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Text(
                                'easy',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Icon(
                                      Icons.timer_sharp,
                                      size: 20,
                                    ),
                                    Text(
                                      snapshot.data!.readyInMinutes.toString(),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 20),
                                    )
                                  ],
                                )),
                            Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data!.weightWatcherSmartPoints
                                          .toString(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    ),
                                    const Text(
                                      'Ingredients',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    )
                                  ],
                                )),
                          ],
                        ),
                        const Divider(
                          height: 15,
                          thickness: 2,
                        ),
                        Html(
                          data: snapshot.data!.summary.toString(),
                        ),
                        const Divider(
                          height: 10,
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              snapshot.data!.servings.toString() + 'serving',
                              style: const TextStyle(color: Colors.black),
                            ),
                            const SizedBox(
                              width: 250,
                            ),
                            Container(
                              child: const Icon(
                                Icons.add,
                                color: Colors.black26,
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Container(
                              child: const Icon(
                                Icons.minimize,
                                color: Colors.black26,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]);
              }
              return Center(
                  child: Container(
                child: const CircularProgressIndicator(),
                height: 100,
                width: 100,
              ));
            }),
      ),
    );
  }
}
