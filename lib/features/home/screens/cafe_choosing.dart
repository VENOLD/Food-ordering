import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:insa_cafeteria/choosing cafe/gojo.dart';
import 'package:insa_cafeteria/choosing cafe/restaurants.dart';
import 'package:insa_cafeteria/choosing cafe/mezenagna.dart';
import 'package:insa_cafeteria/constants/util2.dart';

class CafeChoosing extends StatefulWidget {
  static const String routeName = '/cafe-choosing';

  const CafeChoosing({
    Key? key,
  }) : super(key: key);

  @override
  State<CafeChoosing> createState() => _CafeChoosingState();
}

class _CafeChoosingState extends State<CafeChoosing> {
  final List<String> oferingImages = [
    'https://media.istockphoto.com/photos/ethiopian-food-picture-id870064534?b=1&k=20&m=870064534&s=170667a&w=0&h=PjrjBjMZdmyjXrMLH9sUJzj6DRvdIph-l_tLqebxHyA=',
    'https://media.istockphoto.com/photos/injera-beyaynetu-meal-picture-id869687428?b=1&k=20&m=869687428&s=170667a&w=0&h=ki7veukQoNUeTzSvySIkjUXqELrll0APTUtU6Qh-rHY=',
    'https://media.istockphoto.com/photos/traditional-ethiopian-dish-picture-id452732099?b=1&k=20&m=452732099&s=170667a&w=0&h=KEuMyGlkA7SSML39pvwpwSMqJ9evWrTcc9QdGHcGiLE=',
    'https://media.istockphoto.com/photos/food-from-ethiopia-picture-id972326086?b=1&k=20&m=972326086&s=170667a&w=0&h=3FowDA9rcNoMk0Y-eff0rclL0p11t7cmyL1ntbeS9pw=',
    'https://media.istockphoto.com/photos/ethiopian-cuisine-kitfo-with-greens-and-cheese-ayibe-macro-picture-id636369582?k=20&m=636369582&s=612x612&w=0&h=-KcqvwbQ7w0uXs-AKjAjgCx8Z2ZYieA9CWOnH0MAhIM=',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfSrY6GOVjItFa4Wwds-gPXZzakgNuc0nMLg&usqp=CAU',
    'https://blackrestaurantweeks.com/wp-content/uploads/2021/09/delish-ethiopian-cuisine.jpeg'
  ];
  @override
  Widget build(BuildContext context) {
    Size size = Util(context).getScreenSize;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.33,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.network(
                  oferingImages[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              itemCount: oferingImages.length,
              pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                      color: Colors.white, activeColor: Colors.red)),
            ),
          ),
          const Restaurants(),
          const Cafe1(),
          const Cafe2(),
          // const Cafe3(),
        ],
      ),
    );
  }
}
