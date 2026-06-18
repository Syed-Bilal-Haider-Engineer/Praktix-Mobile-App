import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/api_service.dart';
import '../../data/services/local_storage_service.dart';
import '../../data/repositories/program_repository_impl.dart';
import '../../data/repositories/expert_repository_impl.dart';
import '../../data/repositories/workshop_repository_impl.dart';
import '../../data/repositories/opportunity_repository_impl.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/ai_repository_impl.dart';
import '../../domain/repositories/program_repository.dart';
import '../../domain/repositories/expert_repository.dart';
import '../../domain/repositories/workshop_repository.dart';
import '../../domain/repositories/opportunity_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/ai_repository.dart';

/// Dependency Injection via Riverpod providers.

// --- Services (singletons) ---
final localStorageProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError('LocalStorageService must be overridden in main()');
});

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// --- Repositories (singletons, depend on services) ---
final programRepositoryProvider = Provider<ProgramRepository>((ref) {
  return ProgramRepositoryImpl(
    ref.watch(apiServiceProvider),
    ref.watch(localStorageProvider),
  );
});

final expertRepositoryProvider = Provider<ExpertRepository>((ref) {
  return ExpertRepositoryImpl(
    ref.watch(apiServiceProvider),
    ref.watch(localStorageProvider),
  );
});

final workshopRepositoryProvider = Provider<WorkshopRepository>((ref) {
  return WorkshopRepositoryImpl(ref.watch(apiServiceProvider));
});

final opportunityRepositoryProvider = Provider<OpportunityRepository>((ref) {
  return OpportunityRepositoryImpl(ref.watch(apiServiceProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(apiServiceProvider),
    ref.watch(localStorageProvider),
  );
});

final aiRepositoryProvider = Provider<AiRepository>((ref) {
  return AiRepositoryImpl(ref.watch(apiServiceProvider));
});
