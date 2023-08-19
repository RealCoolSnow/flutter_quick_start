// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) => PageInfo(
      total: json['total'] as int,
      page: json['page'] as int,
      page_size: json['page_size'] as int,
    );

Map<String, dynamic> _$PageInfoToJson(PageInfo instance) => <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'page_size': instance.page_size,
    };
