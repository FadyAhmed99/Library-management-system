import 'package:LibraryManagmentSystem/serializers/available.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given availble json data then from json is called', () async {
    // ARRANGE
    AvailableSerializer available = AvailableSerializer();
    final Map<String, dynamic> _availbleJson = {
      "_id": "1",
      "image": "image",
      "inLibrary": false,
      "itemLink": "http",
      "lateFees": 12,
      "amount":1,
      "location": "12 st",
    };
    // ACT
    available = AvailableSerializer.fromJson(_availbleJson);
    // ASSERT
    expect(available.id, "1");
    expect(available.amount, 1);
    expect(available.image, "image");
    expect(available.inLibrary, false);
    expect(available.itemLink, "http");
    expect(available.lateFees, 12);
    expect(available.location, "12 st");
  });
}
