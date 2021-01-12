import 'package:LibraryManagmentSystem/serializers/available.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given availble json data then fromJson() is called', () async {
    // ARRANGE
    AvailableSerializer available = AvailableSerializer();
    final Map<String, dynamic> _availbleJson = {
      "_id": "1",
      "image": "image",
      "inLibrary": false,
      "itemLink": "http",
      "lateFees": 12,
      "amount": 1,
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

  test('Given availble object data then toJson() is called', () async {
    // ARRANGE
    AvailableSerializer available = AvailableSerializer();
    available = AvailableSerializer(
      id: "1",
      image: "image",
      inLibrary: false,
      itemLink: "http",
      lateFees: 12,
      amount: 1,
      location: "12 st",
    );
    // ACT
    final Map<String, dynamic> _availableJson = available.toJson();
    // ASSERT
    expect(_availableJson['_id'], "1");
    expect(_availableJson['amount'], 1);
    expect(_availableJson['image'], "image");
    expect(_availableJson['inLibrary'], false);
    expect(_availableJson['itemLink'], "http");
    expect(_availableJson['lateFees'], 12);
    expect(_availableJson['location'], "12 st");
  });
}
