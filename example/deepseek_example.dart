import 'package:deepseek/deepseek.dart';

void main() async {
  // Initialize DeepSeek client with your API key
  final deepSeek = DeepSeek("your-api-key");

  try {
    // 🔹 Create a chat completion -> https://api-docs.deepseek.com/api/create-chat-completion
    Completion response = await deepSeek.createChat(
      messages: [Message(role: "user", content: "Hello, how are you?")],
      model: Models.chat.name,
      options: {
        "temperature": 1.0,
        "max_tokens": 4096,
      },
    );
    print("Chat Response: ${response.text}");

    // 🔹 List available models
    List<String> models = await deepSeek.listModels();
    print("Available Models: $models");

    // 🔹 Get user balance
    Balance balance = await deepSeek.getUserBalance();
    print("User Balance: ${balance.info}");
  } on DeepSeekException catch (e) {
    print("Api returned error: ${e.statusCode}:${e.message}");
  } catch (e) {
    print("something unexpected happened: $e");
  }
}
