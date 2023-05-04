import 'package:flutter/material.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/features/home/screens/category_screen2.dart';

class TopCategories2 extends StatelessWidget {
  const TopCategories2({Key? key}) : super(key: key);

  void navigateToCategoryPage(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDealsScreenGojo.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
          itemCount: GlobalVariable.categoryImage2.length,
          scrollDirection: Axis.horizontal,
          itemExtent: 90,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: GestureDetector(
                onTap: () => navigateToCategoryPage(
                    context, GlobalVariable.categoryImage2[index]['title']!),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ClipRRect(
                        child: Image.asset(
                          GlobalVariable.categoryImage2[index]['image']!,
                          fit: BoxFit.fill,
                          height: 40,
                          width: 40,
                        ),
                      ),
                    ),
                    Text(
                      GlobalVariable.categoryImage2[index]['title']!,
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
