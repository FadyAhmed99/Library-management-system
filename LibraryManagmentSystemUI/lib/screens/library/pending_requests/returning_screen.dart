import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class ReturningScrren extends StatefulWidget {
  final String libraryId;
  ReturningScrren(this.libraryId);
  @override
  _ReturningScrrenState createState() => _ReturningScrrenState();
}

class _ReturningScrrenState extends State<ReturningScrren> {
  bool _init = true;
  List<TransactionSerializer> _returnings;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _transactionsProvider = Provider.of<Transaction>(context);

      _transactionsProvider.getReturnRequests().then((err) {
        if (err != null) {
          ourDialog(context: context, error: err);
        } else {
          _returnings = _transactionsProvider.returnings;
        }
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _transactionsProvider = Provider.of<Transaction>(context);

    return _returnings == null
        ? loading()
        : ListView.builder(
            itemCount: _returnings.length,
            itemBuilder: (context, index) {
              return Container(
                margin: kListTileMargin,
                child: ListTile(
                    contentPadding: kListTilePadding,
                    tileColor: Theme.of(context).cardColor,
                    leading:
                        userImage(image: _returnings[index].user.profilePhoto),
                    title: Text(_returnings[index].user.firstname +
                        ' ' +
                        _returnings[index].user.lastname),
                    subtitle: Text(
                      "Item Name: ${_returnings[index].item.name}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    trailing: SmallButton(
                      onPressed: () {
                        _transactionsProvider
                            .receiveItem(transactionId: _returnings[index].id)
                            .then((err) {
                          if (err != null)
                            ourDialog(context: context, error: err, btn1: 'Ok');
                          else {
                            setState(() {
                              _returnings.removeAt(index);
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Item Returned Succefully'),
                              duration: Duration(seconds: 3),
                            ));
                          }
                        });
                      },
                      child: Text('Receive'),
                    )),
              );
            });
  }
}
