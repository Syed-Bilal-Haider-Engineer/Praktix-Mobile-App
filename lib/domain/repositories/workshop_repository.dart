import '../../data/models/workshop.dart';

abstract class WorkshopRepository {
  Future<List<Workshop>> getWorkshops();
}
