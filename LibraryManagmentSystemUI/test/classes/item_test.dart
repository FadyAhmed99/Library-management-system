import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given item json data then from json is called', () async {
    // ARRANGE
    ItemSerializer item = ItemSerializer();
    final Map<String, dynamic> _libraryJson = {
      "_id": "1",
      "ISBN": "isbn",
      "name": "name",
      "genre": "gen",
      "author": "auth",
      "type": "type",
      "language": "lang",
      "available": [
        {
          "location": "",
          "lateFees": 50,
          "inLibrary": false,
          "image": "image",
          "itemLink": "link",
          "_id": "id",
        }
      ],
      "reviews": [
        {"review": "rev", "_id": "id", "rating": 1}
      ],
    };
    // ACT
    item = ItemSerializer.fromJson(_libraryJson);
    // ASSERT
    expect(item.id, "1");
    expect(item.type, "type");
    expect(item.genre, "gen");
    expect(item.name, "name");
    expect(item.isbn, "isbn");
    expect(item.author, "auth");
    expect(item.reviews[0].review, "rev");
  });
}
