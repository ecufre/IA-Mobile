// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

People _$PeopleFromJson(Map<String, dynamic> json) {
  return People(name: json['nombre'] as String, id: json['id'] as int);
}

Map<String, dynamic> _$PeopleToJson(People instance) =>
    <String, dynamic>{'nombre': instance.name, 'id': instance.id};
