import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/loader.dart';
import 'package:insa_cafeteria/features/admin2/models/sales.dart';
import 'package:insa_cafeteria/features/admin2/screens/services/admin_services.dart';
import 'package:insa_cafeteria/features/admin2/widgets/category_food_chart.dart';

class AnalyticsScreenGojo extends StatefulWidget {
  const AnalyticsScreenGojo({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreenGojo> createState() => _AnalyticsScreenGojoState();
}

class _AnalyticsScreenGojoState extends State<AnalyticsScreenGojo> {
  final Admin2Services adminServices = Admin2Services();
  int? totalSales;
  List<SalesGojo>? earnings;
  @override
  void initState() {
    super.initState();

    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '$totalSales  Birr',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 300,
                child: CategoryFoodsChartGojo(seriesList: [
                  charts.Series(
                      id: 'Sales',
                      data: earnings!,
                      domainFn: (SalesGojo sales, _) => sales.lable,
                      measureFn: (SalesGojo sales, _) => sales.earning)
                ]),
              )
            ],
          );
  }
}
