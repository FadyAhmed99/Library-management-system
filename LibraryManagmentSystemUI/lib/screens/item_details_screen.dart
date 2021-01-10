import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/library_image.dart';
import 'package:LibraryManagmentSystem/components/rounded-button.dart';
import 'package:LibraryManagmentSystem/components/user_image.dart';
import 'package:LibraryManagmentSystem/screens/edit_item_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ItemInfoScreen extends StatefulWidget {
  final String libraryId;
  final String itemId;
  const ItemInfoScreen({this.libraryId, this.itemId});

  @override
  _ItemInfoScreenState createState() => _ItemInfoScreenState();
}

class _ItemInfoScreenState extends State<ItemInfoScreen> {
  bool _init = true;
  bool _loading = true;
  UserSerializer _librarian;
  ItemSerializer _item;
  bool _btnLoading = false;

  @override
  void didChangeDependencies() {
    if (_init) {
      final _itemProvider = Provider.of<Item>(context);

      _itemProvider
          .getItemDetails(itemId: widget.itemId, libraryId: widget.libraryId)
          .then((err) {
        if (err == null) {
          setState(() {
            _item = _itemProvider.item;
            _init = false;
            _loading = false;
          });
        } else {
          ourDialog(context: context, error: err);
        }
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User>(context).user;
    final _libraryProvider = Provider.of<Library>(context);
    final _transactionProvider = Provider.of<Transaction>(context);
    final _borrowRequestProvider = Provider.of<BorrowRequest>(context);
    final _itemProvider = Provider.of<Item>(context, listen: true);

    _librarian = _libraryProvider.librarian;

    bool borrowed = false;
    bool requested = false;

    borrowed = (_transactionProvider.borrowedItems.length != 0
        ? _transactionProvider.borrowedItems
                    .where((element) => element.item.id == widget.itemId)
                    .toList()
                    .length ==
                0
            ? false
            : true
        : false);
    requested = (_borrowRequestProvider.borrowRequests.length != 0
        ? _borrowRequestProvider.borrowRequests
                    .where((element) => element.item.id == widget.itemId)
                    .toList()
                    .length ==
                0
            ? false
            : true
        : false);
    _item = _itemProvider.item;

    return Scaffold(
        appBar: appBar(
            backTheme: true,
            context: context,
            title: _loading ? '' : _item.name),
        body: _loading
            ? loading()
            : RefreshIndicator(
                onRefresh: () async {
                  await _itemProvider.getItemDetails(
                      itemId: widget.itemId, libraryId: widget.libraryId);
                  setState(() {
                    _item = _itemProvider.item;
                  });
                },
                child: ListView(
                  children: [
                    Container(
                      color: Colors.grey[400],
                      child: itemImage(image: _item.image, fit: BoxFit.cover),
                    ),
                    _user.librarian
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child:
                                      _libraryProvider.librarian.id != _user.id
                                          ? Container()
                                          : RoundedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditItemInfoScreen(
                                                                item: _item,
                                                                libraryId: widget
                                                                    .libraryId)));
                                              },
                                              title: 'Edit Info',
                                            ),
                                ),
                                SizedBox(width: 15),
                                _libraryProvider.librarian.id != _user.id
                                    ? Container()
                                    : RaisedButton(
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        onPressed: () async {
                                          ourDialog(
                                              context: context,
                                              btn1: 'back',
                                              button2: FlatButton(
                                                child: Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () async {
                                                  await _itemProvider
                                                      .deleteItem(
                                                    itemId: _item.id,
                                                    libraryId: widget.libraryId,
                                                  )
                                                      .then((err) async {
                                                    await _libraryProvider
                                                        .getLibraryItems(
                                                            libraryId: widget
                                                                .libraryId);

                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                    Scaffold.of(context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            'Item deleted successfully'),
                                                      ),
                                                    );
                                                  });
                                                },
                                              ),
                                              error:
                                                  'Are you sure Remove this item?');
                                        },
                                        child: Icon(Icons.delete),
                                      ),
                              ],
                            ),
                          )
                        : _user.librarian
                            ? SizedBox(height: 5)
                            : Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: _btnLoading
                                          ? loading()
                                          : RoundedButton(
                                              onPressed: requested || borrowed
                                                  ? null
                                                  : () {
                                                      setState(() =>
                                                          _btnLoading = true);
                                                      _borrowRequestProvider
                                                          .requestToBorrow(
                                                              libraryId: widget
                                                                  .libraryId,
                                                              itemId:
                                                                  widget.itemId)
                                                          .then((value) async {
                                                        if (value == null) {
                                                          await _borrowRequestProvider
                                                              .getUserBorrowRequests();
                                                          await _transactionProvider
                                                              .getUserBorrowings();
                                                          setState(() =>
                                                              _btnLoading =
                                                                  false);
                                                        } else {
                                                          ourDialog(
                                                              error: value,
                                                              context: context);
                                                          setState(() =>
                                                              _btnLoading =
                                                                  false);
                                                        }
                                                      });
                                                    },
                                              title: requested
                                                  ? 'Requested'
                                                  : borrowed
                                                      ? 'Borrowed'
                                                      : 'Request Borrowing',
                                            ),
                                    ),
                                  ),
                                ],
                              ),

                    // rating

                    Center(
                      child: RatingBarIndicator(
                        itemBuilder: (context, index) {
                          return Icon(
                            Icons.star,
                            color: Colors.blue,
                          );
                        },
                        itemCount: 5,
                        rating: double.parse(_item.averageRating.toString()),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 22),
                      child: Table(
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.top,
                          textDirection: TextDirection.ltr,
                          children: [
                            _emptyRow(15),
                            _row('Item Name', _item.name),
                            _emptyRow(15),
                            _row('Item Type', _item.type),
                            _emptyRow(15),
                            _row('Author', _item.author),
                            _emptyRow(15),
                            _row('Genre', _item.genre),
                            _emptyRow(15),
                            (_item.type == 'ebook' || _item.type == 'book')
                                ? _row('ISBN', _item.isbn)
                                : _emptyRow(0),
                            (_item.type == 'ebook' || _item.type == 'book')
                                ? _emptyRow(15)
                                : _emptyRow(0),
                            !(_item.type == 'ebook' || _item.type == 'article')
                                ? _row('Amount', _item.amount.toString())
                                : _emptyRow(0),
                            !(_item.type == 'ebook' || _item.type == 'article')
                                ? _emptyRow(15)
                                : _emptyRow(0),
                            _item.type == 'book'
                                ? _row('Shelf Number', _item.location)
                                : _emptyRow(0),
                            _item.type == 'book' ? _emptyRow(15) : _emptyRow(0),
                            _row('Language', _item.language),
                            _emptyRow(15),
                            _row(
                                'Status',
                                _item.amount == 0
                                    ? 'Not available'
                                    : 'Available'),
                            _emptyRow(15),
                            _row(
                                _item.type == 'audioMaterial'
                                    ? 'Must be listened in library'
                                    : 'Must be read in library',
                                _item.inLibrary ? 'Yes' : 'No'),
                            _emptyRow(15),
                            _item.inLibrary
                                ? _emptyRow(0)
                                : _row(
                                    'Late Fees',
                                    '\$' +
                                        (_item.lateFees).toString() +
                                        '/day'),
                            _item.inLibrary ? _emptyRow(0) : _emptyRow(15),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '   Reviews:',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _item.reviews.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: ListTile(
                                leading: userImage(
                                    image: _item.reviews[index].profilePhoto),
                                isThreeLine: true,
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _item.reviews[index].firstname.length !=
                                                0 ||
                                            _item.reviews[index].lastname
                                                    .length !=
                                                0
                                        ? Text(
                                            _item.reviews[index].firstname +
                                                ' ' +
                                                _item.reviews[index].lastname,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          )
                                        : Text(
                                            'Unknown',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                    RatingBarIndicator(
                                      itemBuilder: (context, index) {
                                        return Icon(Icons.star,
                                            color: Colors.blue);
                                      },
                                      rating: _item.reviews[index].rating,
                                      itemCount: 5,
                                      itemSize: 18,
                                    )
                                  ],
                                ),
                                contentPadding: EdgeInsets.all(8),
                                subtitle: Text(_item.reviews[index].review,
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                tileColor: Colors.white),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }

  TableRow _row(String label, String data) {
    return TableRow(children: [
      Text(
        label + ': ',
        style: Theme.of(context)
            .textTheme
            .headline1
            .copyWith(fontWeight: FontWeight.normal),
        // textAlign: TextAlign.center,
      ),
      Text(
        data ?? '',
        style: Theme.of(context).textTheme.headline2,

        // textAlign: TextAlign.center,
      ),
    ]);
  }

  TableRow _emptyRow(double height) {
    return TableRow(children: [
      Container(height: height),
      Container(height: height),
    ]);
  }
}
