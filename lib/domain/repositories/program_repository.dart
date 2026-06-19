import '../../data/models/program.dart';

/// Abstract repository interface (domain layer).
///
/// Clean Architecture: the domain layer defines WHAT operations exist.
/// The data layer defines HOW they are implemented (mock API, real HTTP, etc.).
///
/// React analogy: like a TypeScript interface for your API service —
/// components depend on the interface, not the implementation.
abstract class ProgramRepository {
  Future<List<Program>> getPrograms();
  Future<Program?> getProgramById(String id);
  Future<bool> applyToProgram(String programId);
}
