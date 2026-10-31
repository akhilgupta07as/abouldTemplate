import 'package:abould_ada/modules/supabase/models/supabase_task_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SupabaseTaskModel.fromMap parses title row', () {
    final task = SupabaseTaskModel.fromMap({
      'id': '11111111-1111-1111-1111-111111111111',
      'user_id': '22222222-2222-2222-2222-222222222222',
      'title': 'Buy milk',
      'is_completed': false,
      'created_at': '2026-01-01T12:00:00Z',
    });
    expect(task.title, 'Buy milk');
    expect(task.isCompleted, false);
  });
}
