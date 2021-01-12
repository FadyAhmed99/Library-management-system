import 'package:LibraryManagmentSystem/classes/favorite.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given favorite json data then fromJson() is called', () async {
    FavoriteSerializer fav = FavoriteSerializer();
    final Map<String, dynamic> _favJson = {
      "_id": "1",
      "type": "type",
      "language": "lang",
      "genre": "gen",
      "name": "name",
      "ISBN": "isbn",
      "author": "auth",
      "image": "image",
      "amount": 0,
      "inLibrary": true
    };
    // ACT
    fav = FavoriteSerializer.fromJson(_favJson);
    // ASSERT
    expect(fav.id, "1");
    expect(fav.type, "type");
    expect(fav.language, "lang");
    expect(fav.genre, "gen");
    expect(fav.name, "name");
    expect(fav.isbn, "isbn");
    expect(fav.amount, 0);
    expect(fav.genre, "gen");
    expect(fav.image, "image");
    expect(fav.inLibrary, true);
  });

  test('Given favorite object then toJson() is called', () async {
    FavoriteSerializer fav = FavoriteSerializer();
    fav = FavoriteSerializer(
        id: "1",
        type: "type",
        language: "lang",
        genre: "gen",
        name: "name",
        isbn: "isbn",
        author: "auth",
        image: "image",
        amount: 0,
        inLibrary: true);
    // ACT
    final Map<String, dynamic> _favJson = fav.toJson();
    // ASSERT
    expect(_favJson['_id'], "1");
    expect(_favJson['type'], "type");
    expect(_favJson['language'], "lang");
    expect(_favJson['genre'], "gen");
    expect(_favJson['name'], "name");
    expect(_favJson['ISBN'], "isbn");
    expect(_favJson['amount'], 0);
    expect(_favJson['genre'], "gen");
    expect(_favJson['image'], "image");
    expect(_favJson['inLibrary'], true);
  });
}
