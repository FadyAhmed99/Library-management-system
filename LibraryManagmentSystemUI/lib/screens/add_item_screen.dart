import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/components/text_form_field_class.dart';
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddItemScreen extends StatefulWidget {
  final String libraryId;
  const AddItemScreen({@required this.libraryId});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _genre = TextEditingController();
  TextEditingController _author = TextEditingController();
  TextEditingController _isbn = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _imageLink = TextEditingController();
  TextEditingController _itemLink = TextEditingController();
  TextEditingController _lateFees = TextEditingController();
  TextEditingController _language = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  bool _inlibrary = false;
  String _type = 'ebook';

  @override
  Widget build(BuildContext context) {
    List<KFormField> fields = [
      KFormField(
          controller: _name,
          hint: 'Enter Name ',
          label: "Item Name",
          validator: (text) {
            if (text.length == 0) return 'Empty Name';
          }),
      KFormField(
          controller: _genre,
          hint: 'Enter genre ',
          label: "Item Genre",
          validator: (text) {
            if (text.length == 0) return 'Empty';
          }),
      KFormField(
          controller: _author,
          hint: 'Enter author ',
          label: "Item's Author",
          validator: (text) {
            if (text.length == 0) return 'Empty';
          }),
      KFormField(
          controller: _language,
          hint: 'Enter Item Language',
          label: "Item's Language",
          validator: (text) {
            if (text.length == 0) return 'Empty';
          }),
      KFormField(
        textInputType: TextInputType.text,
        controller: _isbn,
        hint: 'Enter ISBN ',
        label: "ISBN",
        validator: (String s) => s.length == 0 ? 'Empty' : null,
      ),
      KFormField(
        textInputType: TextInputType.number,
        controller: _amount,
        hint: 'Enter Amount ',
        label: "Item's Amount",
        validator: (String s) => s.length == 0
            ? 'Empty'
            : double.parse(s, (e) => null) == null
                ? 'Not A Number!'
                : null,
      ),
      KFormField(
          controller: _imageLink,
          hint: 'Enter Image Link',
          label: "Item's Image Link",
          validator: (text) {
            if (text.length == 0) return 'Empty Image Link';
          }),
      KFormField(
          controller: _location,
          hint: 'Enter item\'s location in library',
          label: "Item's location",
          validator: (text) {
            if (text.length == 0) return 'Empty Item\'s location';
          }),
      KFormField(
          controller: _itemLink,
          hint: 'Enter Item Link',
          label: "Item's Link",
          validator: (text) {
            if (text.length == 0) return 'Empty Item\'s Link';
          }),
      KFormField(
        controller: _lateFees,
        hint: 'Enter Item late fees',
        label: "Item's late fees",
        validator: (String s) => s.length == 0
            ? 'Empty'
            : double.parse(s, (e) => null) == null
                ? 'Not A Number!'
                : null,
      )
    ];
    final _itemsProvider = Provider.of<Item>(context);
    final _libraryProvider = Provider.of<Library>(context);
    print(_lateFees.text);
    AutovalidateMode _autoValidate = AutovalidateMode.disabled;
    return Scaffold(
      appBar: appBar(title: 'Add Item', context: context, backTheme: false),
      body: Container(
        child: Center(
          child: Form(
            autovalidateMode: _autoValidate,
            key: _formKey,
            child: ListView(
              cacheExtent: 500,
              addAutomaticKeepAlives: true,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: DropdownButtonFormField(
                      hint: Text(
                        'Enter Item\'s type',
                      ),
                      validator: (value) =>
                          value == null ? 'Empty Enter' : null,
                      autovalidateMode: _autoValidate,
                      items: <String>[
                        'book',
                        'magazine',
                        'ebook',
                        'audio',
                        'article'
                      ]
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: Theme.of(context).textTheme.headline1,
                              )))
                          .toList(),
                      onChanged: (String val) {
                        setState(() {
                          _type = val;
                        });
                      }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: fields.map((e) {
                        if (e.label == 'ISBN') {
                          if (_type == 'ebook' || _type == 'book') {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: myTextFormField(
                                  context: context,
                                  hint: e.hint,
                                  label: e.label,
                                  validator: e.validator,
                                  controller: e.controller),
                            );
                          } else {
                            _isbn.clear();
                            return Container();
                          }
                        }
                        if (_inlibrary && e.label == "Item's late fees") {
                          _lateFees.clear();
                          return Container();
                        }
                        if (_type == 'ebook' || _type == 'article') {
                          if (e.label == "Item's location" ||
                              e.label == "Item's Amount") {
                            _location.clear();
                            _amount.clear();
                            return Container();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: myTextFormField(
                                  context: context,
                                  hint: e.hint,
                                  label: e.label,
                                  validator: e.validator,
                                  controller: e.controller),
                            );
                          }
                        } else {
                          if (e.label == "Item's Link") {
                            _itemLink.clear();
                            return Container();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: myTextFormField(
                                  context: context,
                                  hint: e.hint,
                                  label: e.label,
                                  validator: e.validator,
                                  controller: e.controller),
                            );
                          }
                        }
                      }).toList()),
                ),
                (_type == 'ebook' || _type == 'article')
                    ? Container()
                    : Text(
                        _type == 'audio'
                            ? '   Must be listened in library'
                            : '   Must be read in library',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.grey[700],
                            )),
                _type == 'ebook' || _type == 'article'
                    ? Container(padding: EdgeInsets.only(bottom: 10))
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
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
                                groupValue: _inlibrary,
                                onChanged: (bool val) {
                                  setState(() {
                                    _inlibrary = val;
                                  });
                                },
                              ),
                              Text('Yes'),
                              Radio(
                                value: false,
                                groupValue: _inlibrary,
                                onChanged: (bool val) {
                                  setState(() {
                                    _inlibrary = val;
                                  });
                                },
                              ),
                              Text('No')
                            ]),
                          ],
                        ),
                      ),
                _loading
                    ? loading()
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        child: RoundedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                _autoValidate = AutovalidateMode.disabled;

                                FocusScope.of(context).unfocus();
                                _loading = true;
                              });
                              _itemsProvider
                                  .addItem(
                                      isbn: _isbn.text,
                                      libraryId: widget.libraryId,
                                      inLibrary: _inlibrary,
                                      amount: _amount.text.toString(),
                                      author: _author.text.toString(),
                                      genre: _genre.text.toString(),
                                      image: _imageLink.text,
                                      lateFees: _lateFees.text.length == 0
                                          ? null
                                          : double.parse(_lateFees.text),
                                      link: _itemLink.text,
                                      location: _location.text,
                                      name: _name.text,
                                      type: _type,
                                      language: _language.text)
                                  .then((err) {
                                if (err != null) {
                                  ourDialog(context: context, error: err);
                                  setState(() {
                                    _loading = false;
                                  });
                                } else {
                                  // TODO: add snackbar
                                  _libraryProvider
                                      .getLibraryItems(
                                          libraryId: widget.libraryId)
                                      .then((_) {
                                    Navigator.pop(context);
                                  });
                                }
                              }).catchError(() {
                                ourDialog(
                                    context: context, error: "Request failed");
                                setState(() {
                                  _loading = false;
                                });
                              });
                            } else {
                              setState(() {
                                setState(() {
                                  _autoValidate = AutovalidateMode.always;
                                });
                              });
                            }
                          },
                          title: 'Add Item',
                        ),
                      ),
                SizedBox(height: 15)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
