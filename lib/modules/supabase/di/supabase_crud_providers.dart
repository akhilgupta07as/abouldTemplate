import 'package:abould_ada/modules/authentication/presentation/providers/auth_providers.dart';
import 'package:abould_ada/modules/supabase/data/supabase_profiles_repository.dart';
import 'package:abould_ada/modules/supabase/data/supabase_tasks_repository.dart';
import 'package:abould_ada/modules/supabase/di/supabase_providers.dart';
import 'package:abould_ada/modules/supabase/models/supabase_profile_model.dart';
import 'package:abould_ada/modules/supabase/models/supabase_task_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supabaseCrudEnabledProvider = Provider<bool>((ref) {
  if (!ref.watch(supabaseReadyProvider)) return false;
  if (ref.watch(authSessionBackendProvider) != AuthBackend.supabase) {
    return false;
  }
  final user = ref.watch(currentAuthUserProvider);
  return user != null && user.id.isNotEmpty;
});

final supabaseTasksRepositoryProvider = Provider<SupabaseTasksRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  if (client == null) {
    throw StateError('Supabase client is not available.');
  }
  return SupabaseTasksRepository(client);
});

final supabaseProfilesRepositoryProvider =
    Provider<SupabaseProfilesRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  if (client == null) {
    throw StateError('Supabase client is not available.');
  }
  return SupabaseProfilesRepository(client);
});

final supabaseTasksStreamProvider =
    StreamProvider.autoDispose<List<SupabaseTaskModel>>((ref) {
  if (!ref.watch(supabaseCrudEnabledProvider)) {
    return Stream.value(const []);
  }
  final userId = ref.watch(currentAuthUserProvider)!.id;
  return ref.watch(supabaseTasksRepositoryProvider).watchForUser(userId);
});

final supabaseProfileStreamProvider =
    StreamProvider.autoDispose<SupabaseProfileModel?>((ref) {
  if (!ref.watch(supabaseCrudEnabledProvider)) {
    return Stream.value(null);
  }
  final userId = ref.watch(currentAuthUserProvider)!.id;
  return ref.watch(supabaseProfilesRepositoryProvider).watchProfile(userId);
});
