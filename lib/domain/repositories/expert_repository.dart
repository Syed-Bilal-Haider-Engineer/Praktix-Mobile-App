import '../../data/models/expert.dart';

abstract class ExpertRepository {
  Future<List<Expert>> getExperts();
  Future<Expert?> getExpertById(String id);
  Future<void> toggleFollow(String expertId);
}
