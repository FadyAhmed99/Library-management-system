import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/item_tile.dart';
import 'package:LibraryManagmentSystem/models/item.dart';
import 'package:LibraryManagmentSystem/providers/library_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class LibraryItemsScreen extends StatefulWidget {
  @override
  _LibraryItemsScreenState createState() => _LibraryItemsScreenState();
}

class _LibraryItemsScreenState extends State<LibraryItemsScreen> {
  bool _loading = true;
  bool _init = true;

  List<Item> _lib = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      final _libraryProvider = Provider.of<LibraryProvider>(context);
      _libraryProvider.getLibraries().then((_) {
        setState(() {
          // _lib = _libraryProvider.libraries;
          _loading = false;
        });
      });
      print(_lib);
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? loading()
          : Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                  gridDelegate: kGridShape,
                  itemCount: _lib.length,
                  itemBuilder: (context, index) {
                    return ItemTile();
                  }),
            ),
    );
  }
}
