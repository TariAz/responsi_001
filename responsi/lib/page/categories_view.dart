import 'package:flutter/material.dart';
import 'package:responsi/models/categories_models.dart';
import 'package:responsi/page/meals_view.dart';
import 'package:responsi/services/api_data_source.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesView();
}

class _CategoriesView extends State<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Meal Categories',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 154, 135, 94),
      ),
      body: FutureBuilder(
        future: ApiDataSource.instance.loadCategories(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('ERROR'),
            );
          }
          if (snapshot.hasData) {
            Category category = Category.fromJson(snapshot.data!);
            return ListView.builder(
                itemCount: category.categories?.length,
                itemBuilder: (BuildContext context, int index) {
                  var categories = category.categories?[index];
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MealsView(Category: '${categories?.strCategory}'),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        color: const Color.fromARGB(255, 188, 164, 151),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            children: [
                              Image.network(
                                '${categories?.strCategoryThumb}',
                                height: 150,
                                width: 150,
                              ),
                              Text(
                                '${categories?.strCategory}',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: Text(
                                  '${categories?.strCategoryDescription}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(color: Colors.deepOrange[900]),
          );
        },
      ),
    );
  }
}
