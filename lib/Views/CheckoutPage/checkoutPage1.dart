import 'package:dine/Storage/sharedPreference.dart';
import 'package:dine/Utils/texts.dart';
import 'package:dine/ViewModels/CheckoutPageViewModel/checkoutPageViewModel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    getTableNo();
  }

  Future<void> getTableNo() async {
    final table = await getLocal(key: 'tableNo');
    print('table $table');
    // final prefs = await SharedPreferences.getInstance();
    // final table = prefs.getInt('tableNo') ?? 9;
    setState(() async {
      Constants.tableNo = await int.parse(table);
      tableCtrl.text = Constants.tableNo.toString();
    });
  }

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController phnCtrl = TextEditingController();
  TextEditingController tableCtrl =
      TextEditingController(text: Constants.tableNo.toString());

  @override
  Widget build(BuildContext context) {
    //Future<String> tableNo = getLocal(key: 'tableNo');
    CheckoutViewModel().getCart(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                  setLocal(key: 'tableNo', value: value);
                  Constants.tableNo = int.parse(value);
                },
                //  readOnly: true,
                //  initialValue: Constants.tableNo.toString(),
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
                    context.go("/menu/${Constants.id}/checkout/checkout2");
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
                      ))))
            ],
          ),
        ),
      ),
    );
  }
}
