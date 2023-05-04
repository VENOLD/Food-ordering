import 'package:chapasdk/chapasdk.dart';
import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/common/widgets/custom_textfield.dart';
import 'package:insa_cafeteria/constants/utils.dart';
import 'package:insa_cafeteria/features/address/screens/services/address_services.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  const AddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController floorController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();
  var args;
  int sum = 0;

  @override
  void initState() {
    super.initState();

    paymentItems.add(
      PaymentItem(
        amount: '${sum}',
        label: 'Total Amount ',
        status: PaymentItemStatus.final_price,
      ),
    );
    Future.delayed(Duration.zero, () {
      setState(() {
        if (ModalRoute.of(context)?.settings.arguments != null) {
          args = ModalRoute.of(context)?.settings.arguments;
          print('success');
          print(args['message']);

          if (args['message'] == 'paymentSuccessful') {
            payment();
          } else {
            //generate tran
          }
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    floorController.dispose();
    pinCodeController.dispose();
  }

  void payResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context, address: addressToBeUsed, totalSum: sum);
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";
    bool isForm =
        floorController.text.isNotEmpty || pinCodeController.text.isNotEmpty;
    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed = '${floorController.text}, ${pinCodeController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    user.cart
        .map((e) => sum = e['quantity'] * e['food']['price'] + e['food']['vat'])
        .toList();
    var address = " Addis ababa";
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
                decoration: const BoxDecoration(color: Colors.orange)),
          ),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            if (address.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        address,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Form(
                    key: _addressFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: floorController,
                          hintText: 'Floor Number,',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: pinCodeController,
                          hintText:
                              'PinCode Eg: use your phone no last four digit',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                      text: "pay",
                      color: const Color.fromARGB(255, 231, 167, 93),
                      onTap: () => Chapa.paymentParameters(
                          context: context,
                          publicKey:
                              'CHASECK_TEST-nG1ajQqgByNYD4XScbWwjAZnKMtEvtLQ',
                          currency: 'ETB ',
                          amount: '${sum}',
                          email: user.email,
                          firstName: user.firstName,
                          lastName: user.lastName,
                          txRef: '4r8008r5f00pasii',
                          title: 'kioaf',
                          desc: 'jjj',
                          namedRouteFallBack: '/address')),
                ],
              ),
          ]),
        )));
  }

  void payment() => payResult(paymentItems);
}
