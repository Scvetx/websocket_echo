import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_message.freezed.dart';
part 'websocket_message.g.dart';

@freezed
class WebSocketMessage with _$WebSocketMessage {
  const factory WebSocketMessage({
    required String type,
    required String content,
  }) = _WebSocketMessage;

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) => _$WebSocketMessageFromJson(json);
}


/* json_serializable version
import 'package:json_annotation/json_annotation.dart';

part 'websocket_message.g.dart';

@JsonSerializable()
class WebSocketMessage {
  final String type;
  final String content;

  WebSocketMessage({required this.type, required this.content});

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) => _$WebSocketMessageFromJson(json);
  Map<String, dynamic> toJson() => _$WebSocketMessageToJson(this);
}
*/
