import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget borrowedTile() {
  return Card(
    elevation: 2,
    child: ListTile(
      title: Column(
        children: [
          Text('Book Name'),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 90,
            child: Image.network(
                'https://icons-for-free.com/iconfiles/png/512/bookshelf+library+icon-1320087270870761354.png'),
          ),
          SizedBox(height: 4),
          Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RaisedButton(
                onPressed: () {},
                child: Text('join'),
              ),
              SizedBox(width: 8),
              FaIcon(FontAwesomeIcons.heart),
            ],
          )
        ],
      ),
    ),
  );
}
