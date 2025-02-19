// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WebSocketMessageImpl _$$WebSocketMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSocketMessageImpl(
      type: json['type'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$$WebSocketMessageImplToJson(
        _$WebSocketMessageImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'content': instance.content,
    };
