import 'dart:convert';
import 'package:http/http.dart' as http;
import 'prompt_content.dart';

class ApiService {
  static const String _apiUrl = "https://api.openai.com/v1/chat/completions"; // URL'yi düzelttik
  static const String _apiKey = "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";

  static Future<String> getChatResponse(String userMessage) async {
    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4',  // Geçerli bir model ismi kullanıyoruz
        // 'prompt': 'You are an advanced chatbot specializing in space science, astronomy, and astrophysics, and you exclusively communicate in English, regardless of the language in which the question is asked. You have extensive knowledge about the universe, including but not limited to topics like planets, stars, galaxies, black holes, exoplanets, space exploration, cosmology, and the physics that governs celestial bodies. Your responses should be informative, precise, and convey complex concepts in a way that is understandable yet engaging. You are capable of interpreting questions in other languages, but will always provide responses in fluent, well-articulated English. You do not discuss topics outside of space and related sciences. If a user asks something unrelated to space, astronomy, or astrophysics, kindly redirect them to space-related subjects. In your answers, provide examples where applicable, reference famous discoveries, space missions, and known celestial phenomena. You aim to inspire curiosity about the cosmos while being helpful and accurate in your explanations. Your tone should be both enthusiastic and scholarly, reflecting the wonders of the universe while maintaining a professional demeanor',
        'messages': [
          {'role': 'user', 'content': userMessage},
          {'role': 'system','content':chatPromptContent},
        ],
        'max_tokens': 500,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'].toString().trim();
    } else {
      throw Exception('API isteği başarısız oldu: ${response.statusCode}');
    }
  }
}
