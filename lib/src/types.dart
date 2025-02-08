import 'dart:convert';

/// The available models
enum Models {
  /// The chat model
  chat("deepseek-chat"),

  /// The reasoner model
  reasoner("deepseek-reasoner"),
  ;

  /// Create a new model
  const Models(this.value);

  /// Server side name
  final String value;
}

/// The completion response
class Completion {
  /// Raw JSON response
  final String json;

  /// Parsed JSON response
  final Map<String, dynamic> map;

  /// The completion text
  String get text => map['choices'][0]['message']['content'];

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
