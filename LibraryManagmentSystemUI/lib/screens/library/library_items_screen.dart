import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/item_tile.dart';
import 'package:LibraryManagmentSystem/models/item.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class LibraryItemsScreen extends StatefulWidget {
  final String libraryId;

  const LibraryItemsScreen({Key key, this.libraryId}) : super(key: key);
  @override
  _LibraryItemsScreenState createState() => _LibraryItemsScreenState();
}

class _LibraryItemsScreenState extends State<LibraryItemsScreen> {
  bool _loading = true;
  bool _init = true;

  List<Item> _items = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<LibraryProvider>(context);
      _libraryProvider.getLibraryItems(libraryId: widget.libraryId).then((_) {
        setState(() {
          _items = _libraryProvider.items;
          _loading = false;
        });
      });
      print(_items);
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: null,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Text(
              _loading ? '' : "Library have ${_items.length.toString()} items"),
        ),
      ),
      body: _loading
          ? loading()
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                gridDelegate: kGridShape,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ItemTile(
                    item: _items[index],
                  );
                },
              ),
            ),
    );
  }
}
