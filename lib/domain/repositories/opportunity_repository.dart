import '../../data/models/opportunity.dart';

abstract class OpportunityRepository {
  Future<List<Opportunity>> getOpportunities();
  Future<void> toggleSave(String opportunityId);
}
