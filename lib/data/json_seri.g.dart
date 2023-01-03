// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_seri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonModel _$PersonModelFromJson(Map<String, dynamic> json) => PersonModel(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
    );

Map<String, dynamic> _$PersonModelToJson(PersonModel instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };

TestModel _$TestModelFromJson(Map<String, dynamic> json) => TestModel(
      firstName: json['first_name'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$TestModelToJson(TestModel instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'lastName': instance.lastName,
    };

TestModel2 _$TestModel2FromJson(Map<String, dynamic> json) => TestModel2(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
    );

Map<String, dynamic> _$TestModel2ToJson(TestModel2 instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
    };
