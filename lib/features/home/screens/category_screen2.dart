import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/loader.dart';
import 'package:insa_cafeteria/features/food_detail_gojo/screens/food_detail.dart';
import 'package:insa_cafeteria/features/home/services/home_services_gojo.dart';
import 'package:insa_cafeteria/models/food_gojo.dart';

class CategoryDealsScreenGojo extends StatefulWidget {
  static const String routeName = '/category-deals_gojo';
  final String category;
  const CategoryDealsScreenGojo({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoryDealsScreenGojo> createState() =>
      _CategoryDealsScreenGojoState();
}

class _CategoryDealsScreenGojoState extends State<CategoryDealsScreenGojo> {
  List<FoodGojo>? foodList;
  final HomeServicesGojo homeServices = HomeServicesGojo();
  @override
  void initState() {
    super.initState();
    fetchCategoryFoods();
  }

  fetchCategoryFoods() async {
    foodList = await homeServices.fetchCategoryFoods(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.orange),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: foodList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep Ordering From ${widget.category}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 15),
                      itemCount: foodList!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.4,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        final food = foodList![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, FoodDetailScreenGojo.routeName,
                                arguments: food);
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      food.images[0],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                  left: 0,
                                  top: 5,
                                  right: 15,
                                ),
                                child: Text(
                                  '${food.name}-${food.price.toString()} birr',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }
}
