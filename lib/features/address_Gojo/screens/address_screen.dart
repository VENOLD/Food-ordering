import 'package:flutter/material.dart';
import 'package:insa_cafeteria/common/widgets/custom_button.dart';
import 'package:insa_cafeteria/common/widgets/custom_textfield.dart';
import 'package:insa_cafeteria/constants/utils.dart';
import 'package:insa_cafeteria/features/address_Gojo/services/address_services.dart';
import 'package:insa_cafeteria/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreenGojo extends StatefulWidget {
  static const String routeName = '/address-gojo';
  final String totalAmount;
  const AddressScreenGojo({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreenGojo> createState() => _AddressScreenGojoState();
}

class _AddressScreenGojoState extends State<AddressScreenGojo> {
  final TextEditingController floorController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServicesGojo addressServices = AddressServicesGojo();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount ',
        status: PaymentItemStatus.final_price,
      ),
    );
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
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
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
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace:
              Container(decoration: const BoxDecoration(color: Colors.orange)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
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
                      hintText: 'PinCode Eg: use your phone no last four digit',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: "pay",
                color: const Color.fromARGB(255, 231, 167, 93),
                onTap: () => payResult(paymentItems),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
