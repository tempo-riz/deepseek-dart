import 'dart:convert';

import 'package:deepseek/src/types.dart';
import 'package:http/http.dart' as http;

/// The DeepSeek client
class DeepSeek {
  /// your DeepSeek API key
  ///
  /// get one here: https://platform.deepseek.com/api_keys
  final String apiKey;

  final String baseUrl;

  /// Initialize DeepSeek client with your API key
  DeepSeek(this.apiKey, {this.baseUrl = 'https://api.deepseek.com'});

  Map<String, String> get _headers => {
        'accept': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };

  /// https://api-docs.deepseek.com/api/create-chat-completion
  ///
  /// model defaults to deepseek-chat
  Future<Completion> createChat(
      {required List<Message> messages,
      String? model,
      Map<String, dynamic>? options}) async {
    final res = await http.post(
      Uri.parse('$baseUrl/chat/completions'),
      headers: _headers..['Content-Type'] = 'application/json',
      body: jsonEncode({
        'messages': messages.map((e) => e.toMap()).toList(),
        'model': model ?? Models.chat.name,
        ...?options,
      }),
    );

    if (res.statusCode != 200) {
      throw DeepSeekException.fromBody(res.body, res.statusCode);
    }
    // make sure the response is utf8
    return Completion(utf8.decode(res.bodyBytes));
  }

  /// https://api-docs.deepseek.com/api/list-models
  Future<List<String>> listModels() async {
    final res = await http.get(
      Uri.parse('$baseUrl/models'),
      headers: _headers,
    );

    if (res.statusCode != 200) {
      throw DeepSeekException.fromBody(res.body, res.statusCode);
    }

    final Map<String, dynamic> map = jsonDecode(res.body);

    return List<String>.from(map['data'].map((m) => m['id']));
  }

  /// https://api-docs.deepseek.com/api/get-user-balance
  Future<Balance> getUserBalance() async {
    final res = await http.get(
      Uri.parse('$baseUrl/user/balance'),
      headers: _headers,
    );

    if (res.statusCode != 200) {
      throw DeepSeekException.fromBody(res.body, res.statusCode);
    }

    return Balance(res.body);
  }
}
