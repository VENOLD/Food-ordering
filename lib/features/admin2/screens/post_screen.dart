import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/loader.dart';
import 'package:insa_cafeteria/features/account/widgets/single_item.dart';
import 'package:insa_cafeteria/features/admin2/screens/add_food_screen.dart';
import 'package:insa_cafeteria/features/admin2/screens/services/admin_services.dart';
import 'package:insa_cafeteria/models/food_gojo.dart';

class PostScreenGojo extends StatefulWidget {
  const PostScreenGojo({Key? key}) : super(key: key);

  @override
  State<PostScreenGojo> createState() => _PostScreenGojoState();
}

class _PostScreenGojoState extends State<PostScreenGojo> {
  List<FoodGojo>? food;
  final Admin2Services adminServices = Admin2Services();

  @override
  void initState() {
    super.initState();
    fetchAllFoods();
  }

  fetchAllFoods() async {
    food = await adminServices.fetchAllFoods(context);
    setState(() {});
  }

  void deleteFood(FoodGojo food, int index) {
    adminServices.deleteFood(
      context: context,
      food: food,
      onSuccess: () {
        setState(() {});
      },
    );
  }

  void navigateToAddFood() {
    Navigator.pushNamed(context, AddFoodScreenGojo.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return food == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: food!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final foodData = food![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: SingleItem(
                        image: foodData.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            foodData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteFood(foodData, index),
                          icon: const Icon(
                            Icons.delete_outline_outlined,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: navigateToAddFood,
              tooltip: 'Add a Food',
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
