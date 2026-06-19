import '../../data/models/expert.dart';
import '../../domain/repositories/expert_repository.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class ExpertRepositoryImpl implements ExpertRepository {
  ExpertRepositoryImpl(this._api, this._storage);

  final ApiService _api;
  final LocalStorageService _storage;
  final Set<String> _following = {};

  @override
  Future<List<Expert>> getExperts() async {
    try {
      final data = await _api.getExperts();
      await _storage.cacheExperts(data);
      return data.map((json) {
        final expert = Expert.fromJson(json);
        return expert.copyWith(isFollowing: _following.contains(expert.id));
      }).toList();
    } catch (e) {
      final cached = _storage.cachedExperts;
      if (cached != null) {
        return cached.map((json) {
          final expert = Expert.fromJson(json);
          return expert.copyWith(isFollowing: _following.contains(expert.id));
        }).toList();
      }
      rethrow;
    }
  }

  @override
  Future<Expert?> getExpertById(String id) async {
    final data = await _api.getExpert(id);
    if (data == null) return null;
    final expert = Expert.fromJson(data);
    return expert.copyWith(isFollowing: _following.contains(id));
  }

  @override
  Future<void> toggleFollow(String expertId) async {
    if (_following.contains(expertId)) {
      _following.remove(expertId);
    } else {
      _following.add(expertId);
    }
  }
}
