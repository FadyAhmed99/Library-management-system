import 'package:LibraryManagmentSystem/components/app_bar.dart';
import 'package:LibraryManagmentSystem/components/item_tile.dart';
import 'package:LibraryManagmentSystem/drawer.dart';
import 'package:LibraryManagmentSystem/models/item.dart';
import 'package:flutter/material.dart';
import 'package:LibraryManagmentSystem/constants.dart';
import 'package:LibraryManagmentSystem/components/app_bar.dart';

class FavouriteListScreen extends StatefulWidget {
  @override
  _FavouriteListScreenState createState() => _FavouriteListScreenState();
}

class _FavouriteListScreenState extends State<FavouriteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar:
          appBar(title: 'Favourite List', backTheme: false, context: context),
      body: GridView.builder(
        gridDelegate: kGridShape,
        itemBuilder: (context, index) {
          return ItemTile(
            item: Item(
                name: 'The Lean Startup',
                image: 'kItemPlaceholder',
                isNew: false,
                inLibrary: false,
                amount: 1 
                ),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
