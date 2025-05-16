import 'dart:convert';

import 'package:deepseek/src/utils.dart';

/// The available models
enum Models {
  /// The chat model
  chat("deepseek-chat"),

  /// The reasoner model
  reasoner("deepseek-reasoner"),
  ;

  /// Create a new model
  const Models(this.name);

  /// Server side name
  final String name;
}

/// The completion response
class Completion {
  /// Raw JSON response
  final String json;

  /// Parsed JSON response
  final Map<String, dynamic> map;

  /// The completion text
  String get text => map['choices'][0]['message']['content'];

  /// The completion text rencoded as UTF-8 (chinese)
  ///
  /// Only use this if you have issues with .text
  ///
  /// https://github.com/tempo-riz/deepseek-dart/issues/2
  @Deprecated('not needed anymore, but kept for backward compatibility')
  String get textUtf8 => fixUtf8(text);

  /// Create a new completion object
  Completion(this.json) : map = jsonDecode(json);
}

/// The message model
class Message {
  /// The message content
  final String content;

  /// The message role
  final String role;

  /// The message name
  final String? name;

  /// Create a new message
  Message({
    required this.content,
    required this.role,
    this.name,
  });

  factory Message.fromJson(String source) {
    final map = json.decode(source) as Map<String, dynamic>;
    return Message(
      content: map['content'] as String,
      role: map['role'] as String,
      name: map['name'] as String?,
    );
  }

  Map<String, String?> toMap() => ({
        'content': content,
        'role': role,
        'name': name,
      });

  @override
  String toString() => 'Message(content: $content, role: $role, name: $name)';
}

/// The user balance
class Balance {
  /// Raw JSON response
  final String json;

  /// Parsed JSON response
  final Map<String, dynamic> map;

  /// The user balance object
  Map<String, dynamic> get info => map['balance_infos'][0];

  /// Create a new balance object
  Balance(this.json) : map = jsonDecode(json);
}

/// Represents a DeepSeek API error
class DeepSeekException implements Exception {
// {
//   "error": {
//     "message": "Authentication Fails (no such user)",
//     "type": "authentication_error",
//     "param": null,
//     "code": "invalid_request_error"
//   }
// }

  /// The error message
  final String message;

  /// The error status code
  final int? statusCode;

  /// The error type
  final String? type;

  /// The error parameter
  final String? param;

  /// The error code
  final String? code;

  DeepSeekException(this.message,
      {this.statusCode, this.type, this.param, this.code});

  DeepSeekException.fromMap(Map<String, dynamic> map, {this.statusCode})
      : message = map['message'] ?? 'Unknown error',
        type = map['type'],
        param = map['param'],
        code = map['code'];

  DeepSeekException.fromBody(String body, int statusCode)
      : this.fromMap(_parseBody(body), statusCode: statusCode);

  static Map<String, dynamic> _parseBody(String body) {
    try {
      final json = jsonDecode(body);
      return json['error'] ?? {};
    } catch (e) {
      return {'message': 'Failed to parse error response: $body'};
    }
  }

  @override
  String toString() =>
      'ApiException(message: $message, statusCode: $statusCode, type: $type, param: $param, code: $code)';
}
