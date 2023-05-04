import 'package:flutter/material.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/home/screens/category_deals_screen.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
          itemCount: GlobalVariable.categoryImage.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 80,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: GestureDetector(
                onTap: () => navigateToCategoryPage(
                    context, GlobalVariable.categoryImage[index]['title']!),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          GlobalVariable.categoryImage[index]['image']!,
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                    Text(
                      GlobalVariable.categoryImage[index]['title']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
