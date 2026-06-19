import '../../data/models/opportunity.dart';
import '../../domain/repositories/opportunity_repository.dart';
import '../services/api_service.dart';

class OpportunityRepositoryImpl implements OpportunityRepository {
  OpportunityRepositoryImpl(this._api);

  final ApiService _api;
  final Set<String> _saved = {'opp-1', 'opp-3'};

  @override
  Future<List<Opportunity>> getOpportunities() async {
    final data = await _api.getOpportunities();
    return data.map((json) {
      final opp = Opportunity.fromJson(json);
      return opp.copyWith(isSaved: _saved.contains(opp.id));
    }).toList();
  }

  @override
  Future<void> toggleSave(String opportunityId) async {
    if (_saved.contains(opportunityId)) {
      _saved.remove(opportunityId);
    } else {
      _saved.add(opportunityId);
    }
  }
}
