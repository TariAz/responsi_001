import 'package:flutter/material.dart';
import 'package:responsi/models/meal_models.dart';
import 'package:responsi/page/detail_view.dart';
import 'package:responsi/services/api_data_source.dart';

class MealsView extends StatefulWidget {
  final String Category;
  const MealsView({super.key, required this.Category});

  @override
  State<MealsView> createState() => _MealsView();
}

class _MealsView extends State<MealsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          '${widget.Category.toUpperCase()} Meals',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 154, 135, 94),
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadMeals(widget.Category),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('ERROR'),
            );
          }
          if (snapshot.hasData) {
            Meal meal = Meal.fromJson(snapshot.data!);
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: meal.meals?.length,
                itemBuilder: (context, int index) {
                  final Meals? meals = meal.meals?[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailView(idMeals: '${meals?.idMeal}')));
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 195, 171, 159),
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Image.network(
                                '${meals?.strMealThumb}',
                                height: 120,
                                width: 120,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${meals?.strMeal}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(
                color: const Color.fromARGB(255, 154, 135, 94)),
          );
        },
      ),
    );
  }
}
