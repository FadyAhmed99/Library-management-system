import 'package:json_annotation/json_annotation.dart';

part 'available.g.dart';

@JsonSerializable()
class Available {
  String id;
  String image;
  bool inLibrary;
  String itemLink;
  double lateFees;
  int amount;
  String location;

  Available(
      {this.id,
      this.image,
      this.inLibrary,
      this.itemLink,
      this.lateFees,
      this.amount,
      this.location});

  factory Available.fromJson(Map<String, dynamic> data) =>
      _$AvailableFromJson(data);
  Map<String, dynamic> toJson() => _$AvailableToJson(this);
}
