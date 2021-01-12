import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/serializers/available.dart';
import 'package:LibraryManagmentSystem/serializers/review.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given item json data then fromJson() is called', () async {
    // ARRANGE
    ItemSerializer item = ItemSerializer();
    final Map<String, dynamic> _itemJson = {
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
        {
          "review": "rev",
          "rating": 1,
          "firstname": 'fname',
          "lastname": 'lname',
          "profilePhoto": 'image'
        }
      ],
    };
    // ACT
    item = ItemSerializer.fromJson(_itemJson);
    // ASSERT
    expect(item.id, "1");
    expect(item.type, "type");
    expect(item.genre, "gen");
    expect(item.name, "name");
    expect(item.isbn, "isbn");
    expect(item.author, "auth");
    expect(item.reviews[0].review, "rev");
  });
  test('Given item object then toJson() is called', () async {
    // ARRANGE
    ItemSerializer item = ItemSerializer();
    item = ItemSerializer(
      id: "1",
      isbn: "isbn",
      name: "name",
      genre: "gen",
      author: "auth",
      type: "type",
      language: "lang",
      available: [
        AvailableSerializer(
          location: "",
          lateFees: 50,
          inLibrary: false,
          image: "image",
          itemLink: "link",
          id: "id",
        )
      ],
      reviews: [
        Review(
            review: "rev",
            rating: 1,
            firstname: 'fname',
            lastname: 'lname',
            profilePhoto: 'image'),
      ],
    );
    // ACT
    final Map<String, dynamic> _itemJson = item.toJson();
    // ASSERT
    expect(_itemJson['_id'], "1");
    expect(_itemJson['type'], "type");
    expect(_itemJson['genre'], "gen");
    expect(_itemJson['name'], "name");
    expect(_itemJson['ISBN'], "isbn");
    expect(_itemJson['author'], "auth");
    expect(_itemJson['reviews'][0]['review'], "rev");
    expect(_itemJson['reviews'][0]['firstname'], "fname");
    expect(_itemJson['reviews'][0]['lastname'], "lname");
    expect(_itemJson['reviews'][0]['profilePhoto'], "image");
    expect(_itemJson['reviews'][0]['rating'], 1);
  });
}
