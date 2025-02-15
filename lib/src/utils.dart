import 'dart:convert';

/// Fix text that was incorrectly interpreted as Latin-1 instead of UTF-8.
String fixUtf8(String text) {
  try {
    return utf8.decode(latin1.encode(text));
  } catch (e) {
    return text;
  }
}
