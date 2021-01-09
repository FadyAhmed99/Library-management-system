import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/table_row.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/classes/fee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PayFeeScreen extends StatefulWidget {
  final FeeSerializer fee;

  const PayFeeScreen({this.fee});

  @override
  _PayFeeScreenState createState() => _PayFeeScreenState();
}

class _PayFeeScreenState extends State<PayFeeScreen> {
  TextEditingController _creditCardInfo = TextEditingController();
  TextEditingController _ccv = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final _feesProvider = Provider.of<Fee>(context);

    double _rating = 0;
    return Scaffold(
      appBar: appBar(backTheme: true, title: 'Pay Fee', context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 30),
                Table(
                  children: [
                    row('Item Name', widget.fee.item.name, context),
                    emptyRow(),
                    row('Required Fees', (widget.fee.fees).toString(), context),
                  ],
                ),
                SizedBox(height: 30),
                myTextFormField(
                    context: context,
                    hint: 'Enter Credit Card Number',
                    label: 'Credit Card Number',
                    validator: (String s) => s.length == 0
                        ? null
                        : double.parse(s, (e) => null) == null
                            ? 'Not A Number!'
                            : (s.length == 16)
                                ? null
                                : 'Invalid Number',
                    controller: _creditCardInfo),
                SizedBox(height: 30),
                myTextFormField(
                    context: context,
                    label: 'Enter CVV',
                    hint: 'CVV',
                    validator: (String s) => s.length == 0
                        ? null
                        : double.parse(s, (e) => null) == null
                            ? 'Not A Number!'
                            : (s.length == 3)
                                ? null
                                : 'Invalid Number',
                    controller: _ccv),
                SizedBox(height: 30),
                _loading
                    ? loading()
                    : RoundedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate() &&
                              _rating != null) {
                            setState(() {
                              _loading = true;
                            });
                            FocusScope.of(context).unfocus();
                            _feesProvider
                                .payFee(
                              ccv: int.parse(_ccv.text),
                              creditCardInfo: _creditCardInfo.text,
                              feeId: widget.fee.id,
                            )
                                .then((value) {
                              _feesProvider.getFees().then((value) {
                                Navigator.pop(context);
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text(value),
                                ));
                              });
                            });
                          } else {
                            setState(() {
                              _loading = false;
                            });
                          }
                        },
                        title: 'Pay',
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
