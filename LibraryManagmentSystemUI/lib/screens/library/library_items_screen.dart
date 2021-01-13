import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/dialog.dart';
import 'package:LibraryManagmentSystem/components/item_tile.dart';
import 'package:LibraryManagmentSystem/components/small_button.dart';
import 'package:LibraryManagmentSystem/classes/borrow_request.dart';
import 'package:LibraryManagmentSystem/classes/favorite.dart';
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/classes/library.dart';
import 'package:LibraryManagmentSystem/classes/transaction.dart';
import 'package:LibraryManagmentSystem/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../add_item_screen.dart';

class LibraryItemsScreen extends StatefulWidget {
  final String libraryId;

  const LibraryItemsScreen({Key key, this.libraryId}) : super(key: key);
  @override
  _LibraryItemsScreenState createState() => _LibraryItemsScreenState();
}

class _LibraryItemsScreenState extends State<LibraryItemsScreen> {
  bool _loading = true;
  bool _init = true;

  List<ItemSerializer> _items = [];
  bool _btnLoading = false;
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<Library>(context);

      _libraryProvider.getLibraryItems(libraryId: widget.libraryId).then((_) {
        setState(() {
          _items = _libraryProvider.libraryItems;
          _loading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<User>(context);
    final _libraryProvider = Provider.of<Library>(context);
    final _borrowRequestProvider = Provider.of<BorrowRequest>(context);
    final _transactionProvider = Provider.of<Transaction>(context);
    final _favProvider = Provider.of<Favorite>(context);
    final _subsLibrariesProvider = Provider.of<User>(context);

    _items = _libraryProvider.libraryItems;

    bool borrowed = false;
    bool requested = false;

    void requestBorrow(int index) {
      setState(() => _btnLoading = true);
      bool pending = _subsLibrariesProvider.subs
              .firstWhere((lib) => lib.id == widget.libraryId)
              .status ==
          'pending';

      _borrowRequestProvider
          .requestToBorrow(
              itemId: _items[index].id, libraryId: widget.libraryId)
          .then((err) async {
        if (err != null) {
          setState(() {
            _btnLoading = false;
          });
          ourDialog(
              btn1: 'ok',
              context: context,
              error: err,
              button2: FlatButton(
                child: pending ? null : Text('Send join request'),
                onPressed: () async {
                  setState(() {
                    _btnLoading = false;
                  });

                  await _userProvider
                      .sendJoinRequest(libraryId: widget.libraryId)
                      .then((err) async {
                    if (err == null) {
                      await _subsLibrariesProvider
                          .getSubscribedLibraries()
                          .then((err) {
                        Navigator.pop(context);
                      });
                    }
                  });
                },
              ));
        } else {
          await _borrowRequestProvider.getUserBorrowRequests();
          await _transactionProvider.getUserBorrowings();
          setState(() {
            requested = true;
            _btnLoading = false;
          });
        }
      });
    }

    return Stack(
      children: [
        Scaffold(
          floatingActionButton: _userProvider.user.id ==
                  _libraryProvider.librarian.id
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddItemScreen(libraryId: widget.libraryId)));
                  },
                  child: Icon(Icons.add, color: Colors.blue, size: 25),
                )
              : null,
          body: _loading
              ? loading()
              : RefreshIndicator(
                  onRefresh: () async {
                    await _libraryProvider.getLibraryItems(
                        libraryId: widget.libraryId);
                    await _borrowRequestProvider.getUserBorrowRequests();
                    await _transactionProvider.getUserBorrowings();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ListView(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                _loading
                                    ? ''
                                    : "Library has ${_items.length.toString()} items",
                                style: Theme.of(context).textTheme.headline1),
                          ),
                        ),
                        Container(
                          child: Center(
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate: kGridShape(context: context),
                              itemCount: _items.length,
                              itemBuilder: (context, index) {
                                borrowed = (_transactionProvider
                                            .borrowedItems.length !=
                                        0
                                    ? _transactionProvider.borrowedItems
                                                .where((element) =>
                                                    element.item.id ==
                                                    _items[index].id)
                                                .toList()
                                                .length ==
                                            0
                                        ? false
                                        : true
                                    : false);
                                requested = (_borrowRequestProvider
                                            .borrowRequests.length !=
                                        0
                                    ? _borrowRequestProvider.borrowRequests
                                                .where((element) =>
                                                    element.item.id ==
                                                    _items[index].id)
                                                .toList()
                                                .length ==
                                            0
                                        ? false
                                        : true
                                    : false);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: ItemTile(
                                          borrowed: false,
                                          item: _items[index],
                                          libraryId: widget.libraryId,
                                          favorite: _favProvider
                                                      .favorites.length !=
                                                  0
                                              ? _favProvider.favorites
                                                          .where((element) =>
                                                              element.id ==
                                                              _items[index].id)
                                                          .toList()
                                                          .length ==
                                                      0
                                                  ? false
                                                  : true
                                              : false),
                                    ),
                                    _userProvider.user.librarian
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: SmallButton(
                                                onPressed: borrowed || requested
                                                    ? null
                                                    : () {
                                                        requestBorrow(index);
                                                      },
                                                child: FittedBox(
                                                  child: Text(
                                                    requested
                                                        ? 'Requested'
                                                        : borrowed
                                                            ? "Borrowed"
                                                            : "Request Borrowing",
                                                  ),
                                                )),
                                          ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        _btnLoading
            ? Container(
                color: Colors.grey.withOpacity(0.5),
                child: Center(
                  child: loading(),
                ),
              )
            : Container()
      ],
    );
  }
}
