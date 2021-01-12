// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart' as tDriver;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Library room screen', () {
    tDriver.FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await tDriver.FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      expect(health.status, tDriver.HealthStatus.ok);
    });

    test('library room screen show libraries from data base', () async {
      final libraryTile = tDriver.find.byValueKey('library tile1');
      final libraryName = tDriver.find.byValueKey('name1');
      await driver.waitFor(libraryTile);
      await driver.waitFor(libraryName);
      expect(await driver.getText(libraryName), 'library1');
    });

    test('tap on library to show items', () async {
      final libraryTile = tDriver.find.byValueKey('library tile1');
      final libraryName = tDriver.find.byValueKey('name1');
      final itemName = tDriver.find.byValueKey('name0');
      await driver.waitFor(libraryTile);
      await driver.waitFor(libraryName);
      expect(await driver.getText(libraryName), 'library1');
      await driver.tap(libraryTile);
      await driver.waitFor(itemName);
      expect(await driver.getText(itemName), 'ebook');
    });
  });

  group('Library items screen', () {
    tDriver.FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await tDriver.FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      expect(health.status, tDriver.HealthStatus.ok);
    });

    test('tap on item tile to see details', () async {
      final itemTile = tDriver.find.byValueKey('item_tile_1');
      await driver.waitFor(itemTile);
      await driver.tap(itemTile);
      final itemType = tDriver.find.byValueKey('Item Type');
      await driver.waitFor(itemType);
      expect(await driver.getText(itemType), 'Item Type: ');
    });
    test('tap on request borrowing to borrow item', () async {
      final borrowBtn = tDriver.find.byValueKey('Borrow btn');
      await driver.waitFor(borrowBtn);
      await driver.tap(borrowBtn);
      await driver.waitFor(borrowBtn);
      expect(await driver.getText(borrowBtn), 'Borrowed');
    });
  });

  group('Welcome screen then Sign in', () {
    tDriver.FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await tDriver.FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('check flutter driver health', () async {
      final health = await driver.checkHealth();
      expect(health.status, tDriver.HealthStatus.ok);
    });

    test('tap on log in', () async {
      final loginBtn = tDriver.find.byValueKey('Log in');
      await driver.waitFor(loginBtn);
      await driver.tap(loginBtn);
      final logBtn = tDriver.find.byValueKey('Log in');

      await driver.waitFor(logBtn);
       expect(await driver.getText(logBtn), "Log in");
      await driver.tap(logBtn);
    });
  });
}
