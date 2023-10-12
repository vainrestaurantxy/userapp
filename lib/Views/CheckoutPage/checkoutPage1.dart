import 'package:dine/Utils/texts.dart';
import 'package:dine/ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart' as prov;
import '../../Data/Repositories/MenuPage.dart';
import '../../Utils/Constants/staticConstants.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController nameCtrl = Constants.name != null
      ? TextEditingController(text: Constants.name)
      : TextEditingController();
  TextEditingController phnCtrl = Constants.phone != null
      ? TextEditingController(text: Constants.phone)
      : TextEditingController();
  TextEditingController tableCtrl =
      TextEditingController(text: Constants.tableNo.toString());
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    CheckoutViewModel().getCart(context);
    final repo = prov.Provider.of<MenuPageData>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: giveText('Cart', 20, 600)),
              Align(
                  alignment: Alignment.centerLeft,
                  child: giveText('Add details to view cart', 14, 400)),
              const SizedBox(
                height: 35,
              ),
              TextFormField(
                controller: tableCtrl,
                onChanged: (value) {
                  Constants.tableNo = int.parse(value);
                },
                readOnly: false,
                decoration: InputDecoration(
                    label: const Text("Table Number"),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFF8C8C8C))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameCtrl,
                onTap: () {
                  if (Constants.name != null && flag == false) {
                    flag = true;
                    nameCtrl.text = Constants.name;
                    phnCtrl.text = Constants.phone;
                  }
                },
                onChanged: (v) {
                  Constants.name = v;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                  label: const Text("Customer Name"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF8C8C8C))),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF8C8C8C))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: phnCtrl,
                onChanged: (v) {
                  Constants.phone = v;
                },
                readOnly: false,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefix: giveText('+971 ', 14, 400),
                  hintText: 'Enter Number',
                  label: const Text("Customer Mobile"),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF8C8C8C))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF8C8C8C))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    if (phnCtrl.text.isNotEmpty && phnCtrl.text.length != 9) {
                      final RegExp regex = RegExp(r'^[0-9]+$');
                      if (!regex.hasMatch(phnCtrl.text)) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("phone number should be 0 to 9 digits"),
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("phone number should be 9 digits"),
                        ));
                      }
                    } else if (nameCtrl.text.isNotEmpty &&
                        nameCtrl.text.length < 3) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Name should be more than 3 character"),
                      ));
                    } else {
                      Constants.name = nameCtrl.text;
                      Constants.phone = phnCtrl.text;
                      Constants.tableNo = int.parse(tableCtrl.text);
                      Constants.name != null
                          ? repo.updateUser(
                              macAddress: Constants.macAddress,
                              name: Constants.name,
                              phoneNo: Constants.phone,
                              tableNo: Constants.tableNo)
                          : repo.setUser(
                              macAdderess: Constants.macAddress,
                              name: Constants.name,
                              phoneno: Constants.phone,
                              tableNo: Constants.tableNo);
                      context.go("/menu/${Constants.id}/checkout/checkout2");
                    }
                  },
                  child: Container(
                      width: 396,
                      height: 53,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xff88001f)),
                      child: Center(
                          child: Text(
                        'Proceed to checkout',
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )))),
            ],
          ),
        ),
      ),
    );
  }
}
