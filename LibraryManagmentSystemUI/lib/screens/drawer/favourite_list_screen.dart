import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/circular-loading.dart';
import 'package:LibraryManagmentSystem/components/item_tile.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:LibraryManagmentSystem/drawer.dart';
import 'package:LibraryManagmentSystem/classes/favorite.dart';
import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteListScreen extends StatefulWidget {
  @override
  _FavouriteListScreenState createState() => _FavouriteListScreenState();
}

class _FavouriteListScreenState extends State<FavouriteListScreen> {
  bool _init = true;
  bool _loading = true;
  List<ItemSerializer> _items = [];
  @override
  void didChangeDependencies() {
    if (_init) {
      final _favProvider = Provider.of<Favorite>(context);

      _favProvider.getFavourites().then((_) {
        setState(() {
          _items = _favProvider.favorites;
          _loading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _favProvider = Provider.of<Favorite>(context);
    _items = _favProvider.favorites;

    return Scaffold(
      drawer: drawer(context),
      appBar:
          appBar(title: 'Favourite List', backTheme: false, context: context),
      body: RefreshIndicator(
        onRefresh: () async {
          await _favProvider.getFavourites();
          _items = _favProvider.favorites;
        },
        child: _loading
            ? loading()
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: GridView.builder(
                  gridDelegate: kGridShape(context: context),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: ItemTile(
                            stars: false,
                            item: _items[index],
                            libraryId: _items[index].libraryId,
                            favorite: true,
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: _items.length,
                ),
              ),
      ),
    );
  }
}
