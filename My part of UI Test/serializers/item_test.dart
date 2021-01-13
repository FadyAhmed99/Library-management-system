import 'package:LibraryManagmentSystem/classes/item.dart';
import 'package:LibraryManagmentSystem/serializers/available.dart';
import 'package:LibraryManagmentSystem/serializers/review.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given item json with full data then fromJson() is called', () async {
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
          "location": "location",
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
    expect(item.available[0].location, "location");
    expect(item.available[0].lateFees, 50);
    expect(item.available[0].inLibrary, false);
    expect(item.available[0].itemLink, "link");
    expect(item.available[0].id, "id");
    expect(item.reviews[0].review, "rev");
    expect(item.reviews[0].rating, 1);
    expect(item.reviews[0].firstname, "fname");
    expect(item.reviews[0].lastname, "lname");
    expect(item.reviews[0].profilePhoto, "image");
  });
  test('Given item json without image data then fromJson() is called',
      () async {
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
          "location": "location",
          "lateFees": 50,
          "inLibrary": false,
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
    expect(item.available[0].location, "location");
    expect(item.available[0].lateFees, 50);
    expect(item.available[0].inLibrary, false);
    expect(item.available[0].itemLink, "link");
    expect(item.available[0].image, "");
    expect(item.available[0].id, "id");
    expect(item.reviews[0].review, "rev");
    expect(item.reviews[0].rating, 1);
    expect(item.reviews[0].firstname, "fname");
    expect(item.reviews[0].lastname, "lname");
    expect(item.reviews[0].profilePhoto, "image");
  });

  test(
      'Given item json without lateFees and inLibrary data then fromJson() is called',
      () async {
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
          "location": "location",
          "image": 'image',
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
    expect(item.available[0].location, "location");
    expect(item.available[0].lateFees, 0);
    expect(item.available[0].inLibrary, true);
    expect(item.available[0].itemLink, "link");
    expect(item.available[0].image, "image");
    expect(item.available[0].id, "id");
    expect(item.reviews[0].review, "rev");
    expect(item.reviews[0].rating, 1);
    expect(item.reviews[0].firstname, "fname");
    expect(item.reviews[0].lastname, "lname");
    expect(item.reviews[0].profilePhoto, "image");
  });

  test(
      'Given item json without isbn and language data then fromJson() is called',
      () async {
    // ARRANGE
    ItemSerializer item = ItemSerializer();
    final Map<String, dynamic> _itemJson = {
      "_id": "1",
      "name": "name",
      "genre": "gen",
      "author": "auth",
      "type": "type",
      "available": [
        {
          "location": "location",
          "lateFees": 50,
          "image": 'image',
          "inLibrary": false,
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
    expect(item.language, "");
    expect(item.isbn, "");
    expect(item.author, "auth");
    expect(item.available[0].location, "location");
    expect(item.available[0].lateFees, 50);
    expect(item.available[0].inLibrary, false);
    expect(item.available[0].itemLink, "link");
    expect(item.available[0].image, "image");
    expect(item.available[0].id, "id");
    expect(item.reviews[0].review, "rev");
    expect(item.reviews[0].rating, 1);
    expect(item.reviews[0].firstname, "fname");
    expect(item.reviews[0].lastname, "lname");
    expect(item.reviews[0].profilePhoto, "image");
  });

  test(
      'Given item json without amount and itemLink data then fromJson() is called',
      () async {
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
          "location": "location",
          "lateFees": 50,
          "inLibrary": false,
          "image": 'image',
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
    expect(item.available[0].location, "location");
    expect(item.available[0].lateFees, 50);
    expect(item.available[0].inLibrary, false);
    expect(item.available[0].itemLink, "");
    expect(item.available[0].image, "image");
    expect(item.available[0].amount, 0);
    expect(item.available[0].id, "id");
    expect(item.reviews[0].review, "rev");
    expect(item.reviews[0].rating, 1);
    expect(item.reviews[0].firstname, "fname");
    expect(item.reviews[0].lastname, "lname");
    expect(item.reviews[0].profilePhoto, "image");
  });

  test('Given item json without reviews data then fromJson() is called',
      () async {
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
          "location": "location",
          "lateFees": 50,
          "inLibrary": false,
          "image": 'image',
          "_id": "id",
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
    expect(item.isNew, false);
    expect(item.available[0].location, "location");
    expect(item.available[0].lateFees, 50);
    expect(item.available[0].inLibrary, false);
    expect(item.available[0].itemLink, "");
    expect(item.available[0].image, "image");
    expect(item.available[0].amount, 0);
    expect(item.available[0].id, "id");
  });

  test('Given item json without isNew data then fromJson() is called',
      () async {
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
          "location": "location",
          "lateFees": 50,
          "inLibrary": false,
          "image": 'image',
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
    expect(item.isNew, false);
    expect(item.available[0].location, "location");
    expect(item.available[0].lateFees, 50);
    expect(item.available[0].inLibrary, false);
    expect(item.available[0].itemLink, "");
    expect(item.available[0].image, "image");
    expect(item.available[0].amount, 0);
    expect(item.available[0].id, "id");
    expect(item.reviews[0].review, "rev");
    expect(item.reviews[0].rating, 1);
    expect(item.reviews[0].firstname, "fname");
    expect(item.reviews[0].lastname, "lname");
    expect(item.reviews[0].profilePhoto, "image");
  });

  test('Given item object with full then toJson() is called', () async {
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

  test(
      'Given item object with missing isbn, language, location and itemLink data then toJson() is called',
      () async {
    // ARRANGE
    ItemSerializer item = ItemSerializer();
    item = ItemSerializer(
      id: "1",
      name: "name",
      genre: "gen",
      author: "auth",
      type: "type",
      available: [
        AvailableSerializer(
          lateFees: 50,
          inLibrary: false,
          image: "image",
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
    expect(_itemJson['ISBN'], "");
    expect(_itemJson['author'], "auth");
    expect(_itemJson['reviews'][0]['review'], "rev");
    expect(_itemJson['reviews'][0]['firstname'], "fname");
    expect(_itemJson['reviews'][0]['lastname'], "lname");
    expect(_itemJson['reviews'][0]['profilePhoto'], "image");
    expect(_itemJson['reviews'][0]['rating'], 1);
  });
}
