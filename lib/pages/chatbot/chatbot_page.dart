import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/chatbot_provider.dart';
import '../../models/chat_message.dart';
import 'package:uuid/uuid.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _addBotMessage('Hello! 👋 I\'m here to help. How can I assist you today?');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final chatProvider = context.read<ChatbotProvider>();
    
    // Add user message
    chatProvider.addMessage(ChatMessage(
      id: const Uuid().v4(),
      text: text,
      isUser: true,
      timestamp: DateTime.now(),
    ));

    _controller.clear();
    _scrollToBottom();

    // Simulate bot typing
    chatProvider.setTyping(true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        chatProvider.setTyping(false);
        _generateResponse(text, chatProvider);
      }
    });
  }

  void _generateResponse(String userMessage, ChatbotProvider provider) {
    String response;
    final mode = provider.currentMode;
    
    // Simple keyword-based responses
    final lowerMessage = userMessage.toLowerCase();
    
    if (lowerMessage.contains('autism') || lowerMessage.contains('behavior')) {
      response = mode == 'kid' 
          ? '🌟 Every child is special and unique!'
          : 'Autism is a spectrum. Children may show different behaviors like hand flapping, preference for routines, or sensitivity to sensory input.';
    } else if (lowerMessage.contains('calm') || lowerMessage.contains('help')) {
      response =  mode == 'kid'
          ? '😌 Take deep breaths! In... and out... You\'re doing great!'
          : 'Try these calming strategies: 1) Create a quiet space, 2) Reduce sensory input, 3) Offer comfort items, 4) Use gentle touch if accepted.';
    } else if (lowerMessage.contains('emotion') || lowerMessage.contains('feel')) {
      response = mode == 'kid'
          ? '😊 All feelings are okay! Happy, sad, angry - they\'re all normal!'
          : 'Emotion recognition can be challenging for children with autism. Use visual emotion cards and practice labeling emotions regularly.';
    } else if (lowerMessage.contains('game') || lowerMessage.contains('play')) {
      response = mode == 'kid'
          ? '🎮 Playing games helps you learn! Keep going!'
          : 'Games are excellent learning tools. They provide structured practice in a fun, low-pressure environment.';
    } else {
      response = mode == 'kid'
          ? '😊 That\'s interesting! Tell me more!'
          : 'I understand your concern. Remember: patience, consistency, and acceptance are key when working with children on the autism spectrum.';
    }

    provider.addMessage(ChatMessage(
      id: const Uuid().v4(),
      text: response,
      isUser: false,
      timestamp: DateTime.now(),
    ));

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _addBotMessage(String text) {
    final chatProvider = context.read<ChatbotProvider>();
    chatProvider.addMessage(ChatMessage(
      id: const Uuid().v4(),
      text: text,
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatbotProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Support'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (mode) {
              chatProvider.setMode(mode);
              _addBotMessage('Switched to ${mode == 'kid' ? 'Kid' : mode == 'parent' ? 'Parent' : 'Teacher'} mode!');
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'kid', child: Text('🧒 Kid Mode')),
              const PopupMenuItem(value: 'parent', child: Text('👨‍👩‍👧 Parent Mode')),
              const PopupMenuItem(value: 'teacher', child: Text('🧑‍🏫 Teacher Mode')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Mode indicator
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFF7C4DFF).withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  chatProvider.currentMode == 'kid' ? '🧒' : chatProvider.currentMode == 'parent' ? '👨‍👩‍👧' : '🧑‍🏫',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  '${chatProvider.currentMode.toUpperCase()} MODE',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7C4DFF),
                  ),
                ),
              ],
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: chatProvider.messages.length + (chatProvider.isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (chatProvider.isTyping && index == chatProvider.messages.length) {
                  return _buildTypingIndicator();
                }
                
                final message = chatProvider.messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton(
                  onPressed: () => _sendMessage(_controller.text),
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: message.isUser
              ? const Color(0xFF7C4DFF)
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          '...',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
