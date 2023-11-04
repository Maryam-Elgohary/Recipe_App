import 'package:flutter/material.dart';
import 'package:foodapi/api.dart';
import 'package:foodapi/details.dart';
import 'package:foodapi/recipe_details.dart';
import 'package:foodapi/recipe_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: const Icon(Icons.menu, color: Colors.green, size: 36),
          title: const Text("Recipes",
              style: TextStyle(fontSize: 30, color: Colors.green)),
          centerTitle: true,
          actions: const [Icon(Icons.search, color: Colors.green, size: 36)],
        ),
        body: FutureBuilder<RecipeResponse>(
          future: Api().getData(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
            } else if (snapshot.hasData) {
              List<RecipeDetails>? recipes = snapshot.data!.results;
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.96),
                  itemCount: snapshot.data!.results!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    snapshot.data!.results![index].id,
                                    snapshot.data!.results![index].image,
                                    snapshot.data!.results![index].title,
                                    snapshot.data!.results![index].imageType)));
                          },
                          child: Stack(
                            children: [
                              Container(
                                  child: Column(
                                children: [
                                  Image(
                                      image: NetworkImage(
                                        snapshot.data!.results![index].image
                                            .toString(),
                                      ),
                                      fit: BoxFit.fill),
                                  SizedBox(height: 5),
                                  Expanded(
                                    child: Text(
                                      snapshot.data!.results![index].title
                                          .toString(),
                                      maxLines: 3,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ))
                            ],
                          )),
                    );
                  });
            }
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }),
        ));
  }
}
