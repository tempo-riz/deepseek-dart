<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 

commands :

dart doc
dart format .
flutter pub publish --dry-run

When run pana will make modifications to the package, so start by making a copy of the directory holding your package: cp -r .  ./tmp && dart pub global run pana ./tmp

Make sure you have the latest pana tool: dart pub global activate pana (pana changes frequently, so run this again frequently to update the pana tool)

Run pana on the copy we made earlier: dart pub global run pana ~/tmp/mypkg

-->

A DeepSeek client for dart and flutter. Seamless integration of AI models for text generation and chat.

[![Pub Version](https://img.shields.io/pub/v/deepseek)](https://pub.dev/packages/deepseek)

## Features/endpoints supported

- Create Chat Completion
- List Models
- Get User Balance


You need something else ? Feel free to create issues, contribute to this project or to ask for new features on [GitHub](https://github.com/tempo-riz/deepseek-dart) !

Official docs : https://api-docs.deepseek.com/api/deepseek-api

## Getting started

All you need is a DeepSeek API key. You can get one [here](https://platform.deepseek.com/api_keys)

## Usage

```dart
// Initialize DeepSeek client with your API key
final deepSeek = DeepSeek("your-api-key");

try { 
  // Create a chat completion -> https://api-docs.deepseek.com/api/create-chat-completion
  Completion response = await deepSeek.createChat(
    messages: [Message(role: "user", content: "Hello, how are you?")],
    model: Models.chat.name,
    options: {
      "temperature": 1.0,
      "max_tokens": 4096,
    },
  );
  print("Chat Response: ${response.text}");

  // List available models
  List<String> models = await deepSeek.listModels();
  print("Available Models: $models");

  // Get user balance
  Balance balance = await deepSeek.getUserBalance();
  print("User Balance: ${balance.info}");

} on DeepSeekException catch (e) {
  print("Api returned error: ${e.statusCode}:${e.message}");
} catch (e) {
  print("something unexpected happened: $e");
}
```

## Additional information

I created this package for my own needs. Happy to share !

Don't hesitate to ask for new features or to contribute on [GitHub](https://github.com/tempo-riz/deepseek-dart) !

## Support

If you'd like to support this project, consider contributing [here](https://github.com/sponsors/tempo-riz). Thank you! :)