import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/program.dart';
import '../../data/models/expert.dart';
import '../../data/models/workshop.dart';
import '../../data/models/opportunity.dart';
import 'providers.dart';

/// Combined home screen data state.
class HomeData {
  const HomeData({
    required this.programs,
    required this.experts,
    required this.workshops,
    required this.opportunities,
  });

  final List<Program> programs;
  final List<Expert> experts;
  final List<Workshop> workshops;
  final List<Opportunity> opportunities;
}

/// Fetches all home screen sections in parallel.

final homeDataProvider = FutureProvider<HomeData>((ref) async {
  final results = await Future.wait([
    ref.read(programRepositoryProvider).getPrograms(),
    ref.read(expertRepositoryProvider).getExperts(),
    ref.read(workshopRepositoryProvider).getWorkshops(),
    ref.read(opportunityRepositoryProvider).getOpportunities(),
  ]);

  return HomeData(
    programs: results[0] as List<Program>,
    experts: results[1] as List<Expert>,
    workshops: results[2] as List<Workshop>,
    opportunities: results[3] as List<Opportunity>,
  );
});

final programDetailProvider =
    FutureProvider.family<Program?, String>((ref, id) async {
  return ref.read(programRepositoryProvider).getProgramById(id);
});

final expertDetailProvider =
    FutureProvider.family<Expert?, String>((ref, id) async {
  return ref.read(expertRepositoryProvider).getExpertById(id);
});
