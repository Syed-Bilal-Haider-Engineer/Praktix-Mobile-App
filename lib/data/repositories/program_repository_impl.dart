import '../../data/models/program.dart';
import '../../data/models/certificate.dart';
import '../../domain/repositories/program_repository.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

/// Concrete implementation of [ProgramRepository].
///
/// Fetches from API, caches locally for offline access (bonus feature).
class ProgramRepositoryImpl implements ProgramRepository {
  ProgramRepositoryImpl(this._api, this._storage);

  final ApiService _api;
  final LocalStorageService _storage;

  @override
  Future<List<Program>> getPrograms() async {
    try {
      final data = await _api.getPrograms();
      await _storage.cachePrograms(data);
      return data.map(Program.fromJson).toList();
    } catch (e) {
      final cached = _storage.cachedPrograms;
      if (cached != null) {
        return cached.map(Program.fromJson).toList();
      }
      rethrow;
    }
  }

  @override
  Future<Program?> getProgramById(String id) async {
    final data = await _api.getProgram(id);
    return data != null ? Program.fromJson(data) : null;
  }

  @override
  Future<bool> applyToProgram(String programId) async {
    final result = await _api.applyToProgram(programId);
    return result['success'] as bool? ?? false;
  }

  Future<List<Certificate>> getCertificates() async {
    // In production, this would call the API
    return [];
  }
}
