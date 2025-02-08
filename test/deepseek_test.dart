import 'package:deepseek/deepseek.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  group('[API CLIENT]', () {
    final env = DotEnv()..load();

    final apiKey = env.getOrElse(
        "DEEPSEEK_API_KEY", () => throw Exception("No API Key found"));
    final deepseek = DeepSeek(apiKey);

    test('get user balance', () async {
      final balance = await deepseek.getUserBalance();
      print(balance.info);
      expect(balance.info, isNotEmpty);
    });

    test('list models', () async {
      final models = await deepseek.listModels();
      print(models);
      expect(models, isNotEmpty);
    });

    test('create chat', () async {
      final completion = await deepseek.createChat(
        messages: [Message(role: "user", content: "Hello, how are you?")],
        model: Models.chat,
        options: {
          "temperature": 1.0,
          "max_tokens": 4096,
        },
      );
      print(completion.text);
      expect(completion.map, isNotEmpty);
    });
  });
}
