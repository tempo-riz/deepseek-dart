import 'dart:convert';

import 'package:deepseek/src/types.dart';
import 'package:http/http.dart' as http;

/// The DeepSeek client
class DeepSeek {
  /// your DeepSeek API key
  ///
  /// get one here: https://platform.deepseek.com/api_keys
  final String apiKey;

  final String _baseUrl = 'https://api.deepseek.com';

  /// Initialize DeepSeek client with your API key
  DeepSeek(this.apiKey);

  Map<String, String> get _headers => {
        'accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };

  /// https://api-docs.deepseek.com/api/create-chat-completion
  Future<Completion> createChat(
      {required List<Message> messages,
      Models model = Models.chat,
      Map<String, dynamic>? options}) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/chat/completions'),
      headers: _headers..['Content-Type'] = 'application/json',
      body: jsonEncode({
        'messages': messages.map((e) => e.toMap()).toList(),
        'model': model.value,
        ...?options,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to create chat completion');
    }

    return Completion(res.body);
  }

  /// https://api-docs.deepseek.com/api/list-models
  Future<List<Models>> listModels() async {
    final res = await http.get(
      Uri.parse('$_baseUrl/models'),
      headers: _headers,
    );

    if (res.statusCode != 200) throw Exception('Failed to list models');

    final Map<String, dynamic> map = jsonDecode(res.body);

    return List<Models>.from(map['data']
        .map((m) => Models.values.firstWhere((e) => e.value == m['id'])));
  }

  /// https://api-docs.deepseek.com/api/get-user-balance
  Future<Balance> getUserBalance() async {
    final res = await http.get(
      Uri.parse('$_baseUrl/user/balance'),
      headers: _headers,
    );

    if (res.statusCode != 200) throw Exception('Failed to get user balance');

    return Balance(res.body);
  }
}
