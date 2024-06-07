// ignore_for_file: camel_case_types
import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/common/model.dart';
import 'package:flutter_application_2/common/widget.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;
import '../common/constant.dart';

const backgroundColor = Color(0xff343541);
const botBackgroundColor = Color(0xff444654);

class speechtotxt extends StatefulWidget {
  const speechtotxt({super.key});
  @override
  State<speechtotxt> createState() => _speechtotxtState();
}

Future<String> generateResponse(String prompt) async {
  const apiKey = apiSecretKey;
  var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $apiKey"
    },
    body: json.encode({
      "model": "text-davinci-003",
      "prompt": prompt,
      "temperature": 0.9,
      "max_tokens": 150,
      "top_p": 1,
      "frequency_penalty": 0,
      "presence_penalty": 0.6,
      "stop": [" Human:", " AI:"]
    }),
  );
  Map<String, dynamic> newresponse = jsonDecode(response.body);
  return newresponse['choices'][0]['text'];
}

class _speechtotxtState extends State<speechtotxt> {
  SpeechToText speechToText = SpeechToText();
  final _scrollController = ScrollController();
  var txt = "Hold the button and start speaking";
  var isListening = false;
  final List<ChatMessage> _messages = [];
  @override
  Widget build(BuildContext context) {
    var height = SizeConfig.getHeight(context);
    var width = SizeConfig.getWidth(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 75.0,
        animate: isListening,
        duration: const Duration(milliseconds: 2000),
        glowColor: botBackgroundColor,
        repeat: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        showTwoGlows: true,
        child: GestureDetector(
          onTapDown: (details) async {
            if (!isListening) {
              var available = await speechToText.initialize();
              if (available) {
                setState(() {
                  isListening = true;
                  speechToText.listen(
                    onResult: (result) {
                      setState(() {
                        txt = result.recognizedWords;
                      });
                    },
                  );
                });
              }
            }
          },
          onTapUp: (details) {
            setState(() {
              isListening = false;
            });
            speechToText.stop();
            _messages.add(
              ChatMessage(
                text: txt,
                chatMessageType: ChatMessageType.user,
              ),
            );
            var input = txt;
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
            generateResponse(input).then((value) {
              setState(() {
                _messages.add(
                  ChatMessage(
                    text: value,
                    chatMessageType: ChatMessageType.bot,
                  ),
                );
              });
            });
            Future.delayed(const Duration(milliseconds: 50))
                .then((_) => _scrollDown());
          },
          child: CircleAvatar(
            backgroundColor: botBackgroundColor,
            radius: 35,
            child: Icon(
              isListening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: botBackgroundColor,
        title: const Text(
          "Voice Assistant",
          maxLines: 2,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Text(
                txt,
                style: TextStyle(
                    fontSize: 18,
                    color: isListening ? Colors.black87 : Colors.black54),
              ),
              SizedBox(height: height * 0.02),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  //color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: height * 0.75,
                width: width * 0.99,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      var message = _messages[index];
                      return Chatlayout(
                          chattext: message.text,
                          type: message.chatMessageType);
                    }),
              ),
              //Text(txt, style:TextStyle(fontSize: 18, color: isListening ? Colors.black87 : Colors.black54),),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Chatlayout({required chattext, required ChatMessageType type}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: botBackgroundColor,
          child: type == ChatMessageType.bot
              ? Image.asset("assets/bot1.png", color: Colors.white)
              : const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: type == ChatMessageType.bot
                    ? Colors.black45
                    : backgroundColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Text(
              "$chattext",
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
