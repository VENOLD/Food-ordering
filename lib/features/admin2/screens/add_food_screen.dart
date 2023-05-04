import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/common/widgets/custom_textfield.dart';
import 'package:insa_cafeteria/constants/global_variables.dart';
import 'package:insa_cafeteria/constants/utils.dart';
import 'package:insa_cafeteria/features/admin2/screens/services/admin_services.dart';

class AddFoodScreenGojo extends StatefulWidget {
  static const String routeName = '/add-food-gojo';
  const AddFoodScreenGojo({Key? key}) : super(key: key);

  @override
  State<AddFoodScreenGojo> createState() => _AddFoodScreenGojoState();
}

class _AddFoodScreenGojoState extends State<AddFoodScreenGojo> {
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController vatController = TextEditingController();
  final Admin2Services adminServices = Admin2Services();
  String category = 'የፆም-Fasting';
  List<File> images = [];
  final _addFoodFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    foodNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
    vatController.dispose();
  }

  List<String> foodCategories = [
    'የፆም-Fasting',
    'የፍስክ-feast',
    'ትኩስ መጠጦች-Hot Drinks',
    'ለስላሳ መጠጦች-Soft Drinks',
    'ቡፌ-Buffet',
  ];

  void sellFoods() {
    if (_addFoodFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellFood2(
        context: context,
        name: foodNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        images: images,
        vat: double.parse(vatController.text),
      );
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariable.appBarGradient,
              ),
            ),
            title: const Text(
              'Add Foods/Drinks',
              style: TextStyle(
                color: Colors.black,
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _addFoodFormKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map(
                            (i) {
                              return Builder(
                                builder: (BuildContext context) => Image.file(
                                  i,
                                  fit: BoxFit.cover,
                                  height: 200,
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 200,
                          ),
                        )
                      : GestureDetector(
                          onTap: selectImages,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: 40,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    'Select Food/Drink Images',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade400,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    controller: foodNameController,
                    hintText: 'Food/Drink Name',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: descriptionController,
                    hintText: 'Description',
                    maxLines: 6,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: priceController,
                    hintText: 'Price',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: quantityController,
                    hintText: 'Quantity',
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: vatController,
                    hintText: 'Vat',
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: foodCategories.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String? newVal) {
                        setState(() {
                          category = newVal!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Add-Food',
                    color: const Color.fromARGB(255, 202, 141, 50),
                    onTap: sellFoods,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
