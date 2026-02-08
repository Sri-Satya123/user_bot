import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserBot extends StatefulWidget {
  const UserBot({super.key});

  @override
  State<UserBot> createState() => _UserBotState();
}

class _UserBotState extends State<UserBot> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  bool _isLoading = false;

  final String _endpoint =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=AIzaSyBYAYZkF7ZD0oTpAhF3YqwsD16RKS3wFF8";

  Future<void> _sendMessage(String question) async {
    if (question.trim().isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": question});
      _isLoading = true;
    });

    try {
      final body = {
        "contents": [
          {
            "role": "user",
            "parts": [
              {"text": question},
            ],
          },
        ],
      };

      final response = await http.post(
        Uri.parse(_endpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        String reply = "⚠️ Unexpected response format.";
        try {
          if (decoded["candidates"] is List &&
              decoded["candidates"].isNotEmpty &&
              decoded["candidates"][0]["content"]["parts"] is List) {
            reply = decoded["candidates"][0]["content"]["parts"][0]["text"];
          } else if (decoded["candidates"] is String) {
            reply = decoded["candidates"];
          } else {
            reply = decoded.toString();
          }
        } catch (e) {
          reply = "⚠️ Response parsing error: $e";
        }

        setState(() {
          _messages.add({"role": "bot", "text": reply});
        });
      } else {
        setState(() {
          _messages.add({
            "role": "bot",
            "text":
                "⚠️ Gemini API Error: ${response.statusCode}\n${response.reasonPhrase}",
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"role": "bot", "text": "⚠️ Error: $e"});
      });
    } finally {
      setState(() {
        _isLoading = false;
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 247, 251),
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        toolbarHeight: 70,
        title: const Text("AI ChatBot    🤖", selectionColor: Colors.blue),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg["role"] == "user";
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isUser
                              ? Colors.deepPurpleAccent
                              : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg["text"] ?? "",
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask me something...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.deepPurple),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
