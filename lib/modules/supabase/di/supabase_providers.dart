import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Overridden to `true` in [AppBindings] after successful Supabase init.
final supabaseReadyProvider = Provider<bool>((ref) => false);

final supabaseClientProvider = Provider<SupabaseClient?>((ref) {
  if (!ref.watch(supabaseReadyProvider)) return null;
  return Supabase.instance.client;
});
