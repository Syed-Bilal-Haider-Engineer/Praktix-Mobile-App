import '../../data/models/workshop.dart';
import '../../domain/repositories/workshop_repository.dart';
import '../services/api_service.dart';

class WorkshopRepositoryImpl implements WorkshopRepository {
  WorkshopRepositoryImpl(this._api);

  final ApiService _api;

  @override
  Future<List<Workshop>> getWorkshops() async {
    final data = await _api.getWorkshops();
    return data.map(Workshop.fromJson).toList();
  }
}
