import 'package:json_annotation/json_annotation.dart';

part 'subscribed_library.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscribedLibrary {
  final String id;
  final String name;
  final String address;
  final String image;
  final String phoneNumber;
  final String description;
  final String status;

  SubscribedLibrary(
      {this.id,
      this.name,
      this.address,
      this.image,
      this.phoneNumber,
      this.description,
      this.status});

  factory SubscribedLibrary.fromJson(Map<String, dynamic> data) =>
      _$SubscribedLibraryFromJson(data);
  Map<String, dynamic> toJson() => _$SubscribedLibraryToJson(this);
}
