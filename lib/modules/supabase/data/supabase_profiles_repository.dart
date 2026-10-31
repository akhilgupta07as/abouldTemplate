import 'package:abould_ada/modules/supabase/constants/supabase_tables.dart';
import 'package:abould_ada/modules/supabase/models/supabase_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseProfilesRepository {
  SupabaseProfilesRepository(this._client);

  final SupabaseClient _client;

  Stream<SupabaseProfileModel?> watchProfile(String userId) {
    return _client
        .from(SupabaseTables.profiles)
        .stream(primaryKey: const ['id'])
        .eq('id', userId)
        .map((rows) {
          if (rows.isEmpty) return null;
          return SupabaseProfileModel.fromMap(rows.first);
        });
  }

  Future<void> ensureProfile({
    required String userId,
    required String email,
    String? fullName,
  }) async {
    await _client.from(SupabaseTables.profiles).upsert({
      'id': userId,
      'email': email,
      'full_name': fullName?.trim() ?? '',
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    });
  }
}
