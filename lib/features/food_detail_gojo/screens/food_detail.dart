import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/common/widgets/stars.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/food_detail_gojo/services/food_detail_services.dart';
import 'package:insa_cafeteria/features/home/search/screens/search_screens.dart';
import 'package:insa_cafeteria/models/food_gojo.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:provider/provider.dart';

class FoodDetailScreenGojo extends StatefulWidget {
  static const String routeName = '/food-details-gojo';
  final FoodGojo food;
  const FoodDetailScreenGojo({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  State<FoodDetailScreenGojo> createState() => _FoodDetailScreenGojoState();
}

class _FoodDetailScreenGojoState extends State<FoodDetailScreenGojo> {
  final FoodDetailsServicesGojo foodDetailsServices = FoodDetailsServicesGojo();
  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.food.rating!.length; i++) {
      totalRating += widget.food.rating![i].rating;
      if (widget.food.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.food.rating![i].rating;
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.food.rating!.length;
    }
  }

  void navigateToSearchScreens(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    foodDetailsServices.addToCartGojo(context: context, food: widget.food);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace:
              Container(decoration: const BoxDecoration(color: Colors.orange)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  color: Colors.orange,
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreens,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Food Here.',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(widget.food.id!), Stars(rating: avgRating)],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Text(
              widget.food.name,
              style: const TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          CarouselSlider(
            items: widget.food.images.map(
              (i) {
                return Builder(
                  builder: (BuildContext context) => Image.network(
                    i,
                    fit: BoxFit.contain,
                    height: 200,
                  ),
                );
              },
            ).toList(),
            options: CarouselOptions(
              viewportFraction: 1,
              height: 300,
            ),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: RichText(
              text: TextSpan(
                text: 'Price   ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${widget.food.price} Birr',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: RichText(
              text: TextSpan(
                text: 'Vat 15%:  ',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${widget.food.vat} Birr',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: RichText(
              text: TextSpan(
                text: 'Total Price:  ',
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '${(widget.food.price) + (widget.food.vat)} Birr',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.food.description),
          ),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
                text: 'Order ',
                color: const Color.fromARGB(255, 255, 134, 64),
                onTap: () {}),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomButton(
              text: 'Add to cart',
              onTap: addToCart,
              color: const Color.fromRGBO(254, 216, 19, 1),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.black12,
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Rate The Food',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: GlobalVariable.secondaryColor,
                  ),
              onRatingUpdate: (rating) {
                foodDetailsServices.rateFood(
                  context: context,
                  food: widget.food,
                  rating: rating,
                );
              }),
        ],
      )),
    );
  }
}
