import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:insa_cafeteria/features/admin/models/sales.dart';

class CategoryFoodsChart extends StatelessWidget {
  final List<charts.Series<Sales, String>> seriesList;

  const CategoryFoodsChart({Key? key, required this.seriesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
