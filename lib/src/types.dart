// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Models {
  chat("deepseek-chat"),
  reasoner("deepseek-reasoner"),
  ;

  const Models(this.value);

  final String value;
}

class Completion {
  final String json;

  Completion(this.json);

  Map<String, dynamic> get map => jsonDecode(json);

  String get text => map['choices'][0]['message']['content'];
}

class Message {
  final String content;
  final String role;
  final String? name;

  Message({
    required this.content,
    required this.role,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'role': role,
      'name': name,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['content'] as String,
      role: map['role'] as String,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Message(content: $content, role: $role, name: $name)';

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.content == content && other.role == role && other.name == name;
  }

  @override
  int get hashCode => content.hashCode ^ role.hashCode ^ name.hashCode;
}

class Balance {
  final String json;

  Balance(this.json);

  Map<String, dynamic> get map => jsonDecode(json);

  Map<String, String> get info => map['balance_infos'][0];
}
