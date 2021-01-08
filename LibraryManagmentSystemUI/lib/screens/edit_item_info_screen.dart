import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/components/text_form_field_class.dart';
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditItemInfoScreen extends StatefulWidget {
  final ItemSerializer item;
  final String libraryId;
  const EditItemInfoScreen({@required this.item, @required this.libraryId});

  @override
  _EditItemInfoScreenState createState() => _EditItemInfoScreenState();
}

class _EditItemInfoScreenState extends State<EditItemInfoScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _lateFees = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _imageLink = TextEditingController();
  TextEditingController _itemLink = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool inLibrary;
  @override
  void initState() {
    _name = TextEditingController(text: widget.item.name);
    _location = TextEditingController(text: widget.item.location);
    _lateFees = TextEditingController(text: widget.item.lateFees.toString());
    _amount = TextEditingController(text: widget.item.amount.toString());
    _imageLink = TextEditingController(text: widget.item.image);
    _itemLink = TextEditingController(text: widget.item.itemLink);
    inLibrary = widget.item.inLibrary ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<KFormField> fields = [
      KFormField(
          controller: _location,
          hint: 'Item\'s location in library',
          label: "Location",
          obsecure: false,
          validator: (text) {
            if (text.length == 0) return 'Empty';
          }),
      KFormField(
          controller: _lateFees,
          hint: 'Enter late fees ',
          label: "Late Fees",
          obsecure: false,
          validator: (text) {
            if (text.length == 0) return 'Empty';
          }),
      KFormField(
          controller: _amount,
          hint: 'Enter item\'s amount',
          label: "Amount",
          obsecure: false,
          validator: (String s) => s.length == 0
              ? 'Empty'
              : double.parse(s, (e) => null) == null
                  ? 'Not A Number!'
                  : null),
      KFormField(
          controller: _imageLink,
          hint: 'Enter image link',
          label: "Image link",
          obsecure: false,
          validator: (text) {
            return (text.length == 0) ? 'Empty' : null;
          }),
      KFormField(
          controller: _itemLink,
          obsecure: false,
          hint: 'Enter Item Link',
          label: "Item link",
          validator: (text) {
            if (text.length == 0) return 'Empty';
          }),
    ];
    final _itemProvider = Provider.of<Item>(context);
    return Scaffold(
      appBar:
          appBar(title: 'Edit Item Info', context: context, backTheme: false),
      body: Container(
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListView(
                children: [
                  SizedBox(height: 5),
                  Container(
                      width: 150,
                      height: 150,
                      child: itemImage(
                          image: widget.item.image, fit: BoxFit.scaleDown)),
                  Center(
                      child: Text(
                    widget.item.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  )),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: fields.map((e) {
                        // if ((widget.item.type == 'ebook' ||
                        //             widget.item.type == 'article') &&
                        //         e.label == 'Location' ||
                        //     e.label == 'Amount') {
                        //   return Container();
                        // }
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: myTextFormField(
                                context: context,
                                textInputType: e.textInputType,
                                obsecure: false,
                                hint: e.hint,
                                label: e.label,
                                validator: e.validator,
                                controller: e.controller));
                      }).toList()),
                  Text('  Must be read in library',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.grey[700],
                          )),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 22),
                    child: Table(
                      // border: TableBorder.all(),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2.5),
                        2: FlexColumnWidth(1),
                        3: FlexColumnWidth(2.5),
                      },
                      children: [
                        TableRow(children: [
                          Radio(
                            value: true,
                            groupValue: inLibrary,
                            onChanged: (val) {
                              setState(() {
                                inLibrary = val;
                              });
                            },
                          ),
                          Text('Yes'),
                          Radio(
                            value: false,
                            groupValue: inLibrary,
                            onChanged: (val) {
                              setState(() {
                                inLibrary = val;
                              });
                            },
                          ),
                          Text('No')
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  _loading
                      ? loading()
                      : RoundedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                FocusScope.of(context).unfocus();
                                _loading = true;
                              });
                              _itemProvider
                                  .editItemInfo(
                                      libraryId: widget.libraryId,
                                      itemId: widget.item.id,
                                      amount: num.parse(_amount.text) ?? 0,
                                      image: _imageLink.text,
                                      lateFees: _lateFees.text,
                                      link: _itemLink.text,
                                      inLibrary: inLibrary,
                                      location: _location.text,
                                      name: _name.text)
                                  .then((err) {
                                if (err != null) {
                                  ourDialog(context: context, error: err);
                                } else {
                                  // TODO: add snackbar
                                  _itemProvider
                                      .getItemDetails(
                                          libraryId: widget.libraryId,
                                          itemId: widget.item.id)
                                      .then((value) {
                                    Navigator.pop(context);
                                  });
                                }
                              });
                            }
                          },
                          title: 'Submit',
                        ),
                  SizedBox(height: 15)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
