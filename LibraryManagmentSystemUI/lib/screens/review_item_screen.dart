import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/table_row.dart';
import 'package:LibraryManagmentSystem/components/text-field.dart';
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewItemScreen extends StatefulWidget {
  final String libraryId;
  final String itemId;
  final String itemName;
  final bool refresh;
  const ReviewItemScreen(
      {this.libraryId, this.itemId, this.itemName, this.refresh});

  @override
  _ReviewItemScreenState createState() => _ReviewItemScreenState();
}

class _ReviewItemScreenState extends State<ReviewItemScreen> {
  TextEditingController _text = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _errorMsg = false;
  double _rating = 0.0;
  bool rated = false;
  @override
  Widget build(BuildContext context) {
    final _itemProvider = Provider.of<Item>(context);
    final _userProvider = Provider.of<User>(context);
    final _transactionProvider = Provider.of<Transaction>(context);

    return Scaffold(
      appBar: appBar(backTheme: true, title: 'Review Item', context: context),
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
                  children: [row('Item Name', widget.itemName, context)],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      'Your Rating*: ',
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RatingBar.builder(
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.star,
                              color: Colors.blue,
                            );
                          },
                          onRatingUpdate: (rating) {
                            setState(() {
                              _rating = rating;
                            });
                          },
                          itemCount: 5,
                          allowHalfRating: true,
                          unratedColor: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                _rating != 0.0
                    ? Container()
                    : Center(
                        child: Text('Rating with stars is required',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.red))),
                SizedBox(height: 30),
                myTextFormField(
                    context: context,
                    hint: 'Write Review here',
                    label: 'Review',
                    validator: (text) {
                      if (text.length == 0) return 'Empty Text';
                    },
                    controller: _text),
                SizedBox(height: 15),
                _loading
                    ? loading()
                    : RoundedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate() &&
                              _rating != 0.0) {
                            setState(() {
                              _loading = true;
                            });
                            FocusScope.of(context).unfocus();
                            _itemProvider
                                .reviewItem(
                                    itemId: widget.itemId,
                                    libraryId: widget.libraryId,
                                    review: _text.text,
                                    rating: _rating)
                                .then((value) async {
                              if (value == null) {
                                // TODO: Snack
                                // caching rev
                                SharedPreferences _prefs =
                                    await SharedPreferences.getInstance();
                                await _prefs.setString(
                                    _userProvider.user.id + widget.itemId,
                                    'rev');
                                widget.refresh == null
                                    ? null
                                    : widget.refresh
                                        ? await _transactionProvider
                                            .getReturningLogs()
                                        : await _transactionProvider
                                            .getBorrowinglogs();
                                Navigator.pop(context);
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 2),
                                  content: Text(value),
                                ));
                              } else {
                                ourDialog(
                                    context: context,
                                    error: value,
                                    btn1: '',
                                    button2: FlatButton(
                                      child: Text('ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                    ));
                              }
                            });
                          } else {
                            setState(() {
                              _loading = false;
                              _errorMsg = true;
                            });
                          }
                        },
                        title: 'Send',
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
