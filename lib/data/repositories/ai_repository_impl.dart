import '../../domain/repositories/ai_repository.dart';
import '../services/api_service.dart';

class AiRepositoryImpl implements AiRepository {
  AiRepositoryImpl(this._api);

  final ApiService _api;

  @override
  Future<String> getResponse(String question) => _api.getAiResponse(question);
}
