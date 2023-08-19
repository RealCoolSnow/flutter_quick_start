import 'package:json_annotation/json_annotation.dart';

part 'page_info.g.dart';

@JsonSerializable()
class PageInfo {
  final int total;
  final int page;
  final int page_size;

  PageInfo({required this.total, required this.page, required this.page_size});

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PageInfoToJson(this);
}
