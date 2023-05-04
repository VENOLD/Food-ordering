import 'package:flutter/material.dart';

String uri = 'http://192.168.0.30:3000';

class GlobalVariable {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const List<String> carouselImages2 = [
    'assets/images/gojo2.jpg',
    'assets/images/gojo3.jpg',
    'assets/images/gojo4.jpg',
    'assets/images/gojo5.jpg',
  ];
  static const List<String> carouselImages = [
    'https://media.istockphoto.com/photos/ethiopian-food-picture-id870064534?b=1&k=20&m=870064534&s=170667a&w=0&h=PjrjBjMZdmyjXrMLH9sUJzj6DRvdIph-l_tLqebxHyA=',
    'https://media.istockphoto.com/photos/injera-beyaynetu-meal-picture-id869687428?b=1&k=20&m=869687428&s=170667a&w=0&h=ki7veukQoNUeTzSvySIkjUXqELrll0APTUtU6Qh-rHY=',
    'https://media.istockphoto.com/photos/traditional-ethiopian-dish-picture-id452732099?b=1&k=20&m=452732099&s=170667a&w=0&h=KEuMyGlkA7SSML39pvwpwSMqJ9evWrTcc9QdGHcGiLE=',
    'https://media.istockphoto.com/photos/food-from-ethiopia-picture-id972326086?b=1&k=20&m=972326086&s=170667a&w=0&h=3FowDA9rcNoMk0Y-eff0rclL0p11t7cmyL1ntbeS9pw=',
    'https://media.istockphoto.com/photos/ethiopian-cuisine-kitfo-with-greens-and-cheese-ayibe-macro-picture-id636369582?k=20&m=636369582&s=612x612&w=0&h=-KcqvwbQ7w0uXs-AKjAjgCx8Z2ZYieA9CWOnH0MAhIM=',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfSrY6GOVjItFa4Wwds-gPXZzakgNuc0nMLg&usqp=CAU',
    'https://blackrestaurantweeks.com/wp-content/uploads/2021/09/delish-ethiopian-cuisine.jpeg'
  ];

  static const List<Map<String, String>> categoryImage = [
    {'title': 'Fasting', 'image': 'assets/images/yesome_1.jpg'},
    {'title': 'feast', 'image': 'assets/images/yefeseg_2.jpg'},
    {
      'title': 'Hot Drinks',
      'image': 'assets/images/coffee_icon.jpg',
    },
    {
      'title': 'Soft Drinks',
      'image': 'assets/images/soft_drink.jpg',
    },
    {'title': 'Buffet', 'image': 'assets/images/buffet.jpg'}
  ];
  static const List<Map<String, String>> categoryImage2 = [
    {'title': 'የፆም-Fasting', 'image': 'assets/images/yesome_1.1.png'},
    {'title': 'የፍስክ-feast', 'image': 'assets/images/gojo_tebse1.png'},
    {
      'title': 'ትኩስ መጠጦች-Hot Drinks',
      'image': 'assets/images/hot_drink_gojo.jpg',
    },
    {
      'title': 'ለስላሳ መጠጦች-Soft Drinks',
      'image': 'assets/images/soft_drink.jpg',
    },
    {'title': 'ቡፌ-Buffet', 'image': 'assets/images/buffet1.png'}
  ];
  static const List<Map<String, String>> categorygojo = [
    {
      'title-gojo': 'Gojo Restaurant',
      'image-gojo': 'assets/images/yefeseg_2.jpg'
    },
  ];
  static const List<Map<String, String>> categorymezenagna = [
    {
      'title-mezenagna': 'Mezenagna Restaurant',
      'image-mezenagna': 'assets/images/yesome_1.jpg'
    },
  ];
}
