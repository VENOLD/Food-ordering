import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/loader.dart';
import 'package:insa_cafeteria/features/account/widgets/single_item.dart';
import 'package:insa_cafeteria/features/admin/screens/add_food_screen.dart';

import 'package:insa_cafeteria/features/admin/screens/services/admin_services.dart';
import 'package:insa_cafeteria/models/food.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Food>? food;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllFoods();
  }

  fetchAllFoods() async {
    food = await adminServices.fetchAllFoods(context);
    setState(() {});
  }

  void deleteFood(Food food, int index) {
    adminServices.deleteFood(
      context: context,
      food: food,
      onSuccess: () {
        setState(() {});
      },
    );
  }

  void changeFoodStatus(Food foood, int isAvailable) {
    adminServices.changeFoodStatus(
        context: context,
        isAvailable: 1,
        food: foood,
        onSuccess: () {
          setState(() {});
        });
  }

  void changeFoodStatusAvailable(Food foood, int isAvailable) {
    adminServices.changeFoodStatus(
        context: context,
        isAvailable: 0,
        food: foood,
        onSuccess: () {
          setState(() {});
        });
  }

  void navigateToAddFood() {
    Navigator.pushNamed(context, AddFoodScreen.routeName);
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
                        IconButton(
                          onPressed: () =>
                              changeFoodStatusAvailable(foodData, index),
                          icon: const Icon(Icons.notifications_active_outlined),
                        ),
                        IconButton(
                          onPressed: () => changeFoodStatus(foodData, index),
                          icon: const Icon(Icons.notifications_off_outlined),
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
