import 'package:deepseek/deepseek.dart';

void main() async {
  // Initialize DeepSeek client with your API key
  final deepSeek = DeepSeek("your-api-key");

  try {
    // 🔹 List available models
    List<Models> models = await deepSeek.listModels();
    print("Available Models: ${models.map((m) => m.value).join(', ')}");

    // 🔹 Create a chat completion
    Completion response = await deepSeek.createChat(
      messages: [Message(role: "user", content: "Hello, how are you?")],
    );
    print("Chat Response: ${response.text}");

    // 🔹 Get user balance
    Balance balance = await deepSeek.getUserBalance();
    print("User Balance: $balance");
  } catch (e) {
    print("Error: $e");
  }
}
