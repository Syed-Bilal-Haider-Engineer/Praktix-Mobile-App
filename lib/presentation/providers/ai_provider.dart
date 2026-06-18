import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/chat_message.dart';
import 'providers.dart';

/// AI chat state — manages message history and sending.
class AiChatNotifier extends StateNotifier<List<ChatMessage>> {
  AiChatNotifier(this._ref) : super([]) {
    _addWelcomeMessage();
  }

  final Ref _ref;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _addWelcomeMessage() {
    state = [
      ChatMessage.assistant(
        'Hello! I am your AI Career Advisor at Praktix. '
        'I can help you choose programs, certifications, and plan your career path.\n\n'
        'Try asking:\n'
        '• Which program should I take?\n'
        '• Which certification fits me?\n'
        '• How can I move into AI?',
      ),
    ];
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty || _isLoading) return;

    state = [...state, ChatMessage.user(text)];
    _isLoading = true;

    try {
      final response =
          await _ref.read(aiRepositoryProvider).getResponse(text);
      state = [...state, ChatMessage.assistant(response)];
    } catch (e) {
      state = [
        ...state,
        ChatMessage.assistant(
          'Sorry, I encountered an error. Please try again.',
        ),
      ];
    } finally {
      _isLoading = false;
    }
  }

  void sendQuickQuestion(String question) => sendMessage(question);
}

final aiChatProvider =
    StateNotifierProvider<AiChatNotifier, List<ChatMessage>>((ref) {
  return AiChatNotifier(ref);
});

final aiLoadingProvider = Provider<bool>((ref) {
  ref.watch(aiChatProvider);
  return ref.read(aiChatProvider.notifier).isLoading;
});
