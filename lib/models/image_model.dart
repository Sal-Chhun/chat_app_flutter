import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

// "albumId": 1,
// "id": 1,
// "title": "accusamus beatae ad facilis cum similique qui sunt",
// "url": "https://via.placeholder.com/600/92c952",
// "thumbnailUrl": "https://via.placeholder.com/150/92c952"

@JsonSerializable()
class PixelfordImage {
 // The generated code assumes these values exist in JSON.
 final String? title;
 final int albumId;
 final int id;
 final String url;
 final String thumbnailUrl;

 PixelfordImage({
  this.title,
  required this.albumId,
  required this.id,
  required this.url,
  required this.thumbnailUrl,
 });

 // Connect the generated [_$PixelfordImageFromJson] function to the `fromJson` factory.
 factory PixelfordImage .fromJson(Map<String, dynamic> json) => _$PixelfordImageFromJson(json);

 // Connect the generated [_$PixelfordImageToJson] function to the `toJson` method.
 Map<String, dynamic> toJson() => _$PixelfordImageToJson(this);
}