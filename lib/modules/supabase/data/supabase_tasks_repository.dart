import 'package:abould_ada/modules/supabase/constants/supabase_tables.dart';
import 'package:abould_ada/modules/supabase/models/supabase_task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTasksRepository {
  SupabaseTasksRepository(this._client);

  final SupabaseClient _client;

  Stream<List<SupabaseTaskModel>> watchForUser(String userId) {
    return _client
        .from(SupabaseTables.adaTasks)
        .stream(primaryKey: const ['id'])
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .map(
          (rows) => rows
              .map((row) => SupabaseTaskModel.fromMap(row))
              .toList(growable: false),
        );
  }

  Future<SupabaseTaskModel> create({
    required String userId,
    required String title,
  }) async {
    final trimmed = title.trim();
    final row = await _client
        .from(SupabaseTables.adaTasks)
        .insert(
          SupabaseTaskModel(
            id: '',
            userId: userId,
            title: trimmed,
            isCompleted: false,
            createdAt: DateTime.now(),
          ).toInsertMap(userId: userId, title: trimmed),
        )
        .select()
        .single();
    return SupabaseTaskModel.fromMap(row);
  }

  Future<void> updateTitle({
    required SupabaseTaskModel task,
    required String title,
  }) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return;
    await _client
        .from(SupabaseTables.adaTasks)
        .update({'title': trimmed})
        .eq('id', task.id)
        .eq('user_id', task.userId);
  }

  Future<void> setCompleted({
    required SupabaseTaskModel task,
    required bool isCompleted,
  }) async {
    await _client
        .from(SupabaseTables.adaTasks)
        .update({'is_completed': isCompleted})
        .eq('id', task.id)
        .eq('user_id', task.userId);
  }

  Future<void> toggleCompleted(SupabaseTaskModel task) =>
      setCompleted(task: task, isCompleted: !task.isCompleted);

  Future<void> remove(SupabaseTaskModel task) async {
    await _client
        .from(SupabaseTables.adaTasks)
        .delete()
        .eq('id', task.id)
        .eq('user_id', task.userId);
  }
}
