import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/loader.dart';
import 'package:insa_cafeteria/features/food_details/screens/food_detail.dart';
import 'package:insa_cafeteria/features/home/services/home_services.dart';
import 'package:insa_cafeteria/models/food.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  Food? food;
  Food? name;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    super.initState();
    fetchSaleOfDay();
  }

  void fetchSaleOfDay() async {
    food = await homeServices.fetchSaleOdDay(context: context);
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, FoodDetailScreen.routeName, arguments: food);
  }

  @override
  Widget build(BuildContext context) {
    return food == null
        ? const Loader()
        : food!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToDetailScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Sale Of The Day',
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ),
                    Image.network(
                      food!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        '${food!.price.toString()} Birr',
                        style: const TextStyle(fontSize: 18, color: Colors.red),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 5,
                        right: 15,
                      ),
                      child: Text(
                        food!.name.toString(),
                        style: const TextStyle(fontSize: 17),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: food!.images
                            .map(
                              (e) => Image.network(
                                food!.images[0],
                                fit: BoxFit.fitWidth,
                                width: 100,
                                height: 100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all Sales',
                        style: TextStyle(color: Colors.cyan[800]),
                      ),
                    )
                  ],
                ),
              );
  }
}
