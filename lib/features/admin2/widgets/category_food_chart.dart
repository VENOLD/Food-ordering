import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:insa_cafeteria/features/admin2/models/sales.dart';

class CategoryFoodsChartGojo extends StatelessWidget {
  final List<charts.Series<SalesGojo, String>> seriesList;

  const CategoryFoodsChartGojo({Key? key, required this.seriesList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
