import 'package:dart_g2_stores/features/address/services/address_services.dart';
import 'package:dart_g2_stores/features/address/widgets/payment_bottom_modal.dart';
import 'package:dart_g2_stores/provider/user_provider.dart';
import 'package:dart_g2_stores/shared/app%20elements/app_colors.dart';
import 'package:dart_g2_stores/shared/utils/utils.dart';
import 'package:dart_g2_stores/shared/widgets/custom_button.dart';
import 'package:dart_g2_stores/shared/widgets/custom_textfield.dart';
import 'package:dart_g2_stores/shared/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = '';

  final AddressServices addressServices = AddressServices();

  @override
  void dispose() {
    super.dispose();
    flatController.dispose();
    streetController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onPayResult() {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        address: addressToBeUsed,
      );
    }
    // showSnackBar(
    //   context,
    //   'Order has been placed',
    // );
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUsed = '';

    bool isForm = flatController.text.isNotEmpty ||
        streetController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatController.text}, ${streetController.text}, ${pincodeController.text}, ${cityController.text}';
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'ERROR!');
    }
    //print(addressToBeUsed);
    showMaterialModalBottomSheet(
      context: context,
      builder: (BuildContext context) => PaymentBottomModal(
        confirmPayment: () {
          onPayResult();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    // var address = 'Some fake address';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.blue02,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: GlobalVariables.appBarGradient,
              color: Colors.transparent,
            ),
          ),
          title: const Text('Confirm Address'),
          centerTitle: false,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: Column(
              children: [
                if (address.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[600]!)),
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Text(
                            address,
                            style: TextStyle(
                              fontSize: 19.sp,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.h),
                        child: Text(
                          'OR',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19.sp),
                        ),
                      ),
                    ],
                  ),
                Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: flatController,
                        hintText: 'Flat/House No/Building',
                      ),
                      Spc(h: 10.h),
                      CustomTextField(
                        controller: streetController,
                        hintText: 'Area/Street',
                      ),
                      Spc(h: 10.h),
                      CustomTextField(
                        controller: pincodeController,
                        hintText: 'ZipCode',
                      ),
                      Spc(h: 10.h),
                      CustomTextField(
                        controller: cityController,
                        hintText: 'Town/City',
                      ),
                      Spc(h: 10.h),
                      CustomButton(
                        color: AppColors.primaryBlue,
                        text: 'Pay',
                        onTap: () => payPressed(address),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
