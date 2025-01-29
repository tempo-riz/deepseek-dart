import 'package:deepseek/src/types.dart';
import 'package:http/http.dart' as http;

/// The DeepSeek client
class DeepSeek {
  /// your DeepSeek API key
  final String apiKey;

  final String _baseUrl = 'https://api.deepseek.com';

  DeepSeek(this.apiKey);

  /// https://api-docs.deepseek.com/api/create-chat-completion
  Future<Completion> createChat({
    required List<Message> messages,
    Models model = Models.chat,
    Map<String, dynamic>? options,
  }) async {
    final String endpoint = '/chat/completions';
    // TODO
    return Completion("TODO");
  }

  /// https://api-docs.deepseek.com/api/list-models
  Future<List<Models>> listModels() async {
    final String endpoint = '/models';
    // TODO
    return [];
  }

  /// https://api-docs.deepseek.com/api/get-user-balance
  Future<Balance> getUserBalance() async {
    final String endpoint = '/user/balance';
    // TODO
    return Balance("TODO");
  }
}
