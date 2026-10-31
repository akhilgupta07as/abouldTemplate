import 'package:abould_ada/core/config/auth_backend.dart';
import 'package:abould_ada/modules/authentication/domain/auth_repository.dart';

class AuthRepositoryRegistry {
  const AuthRepositoryRegistry({
    required this.dummyJson,
    required this.firebase,
    required this.supabase,
  });

  final AuthRepository dummyJson;
  final AuthRepository firebase;
  final AuthRepository supabase;

  AuthRepository resolve(AuthBackend backend) {
    return switch (backend) {
      AuthBackend.dummyJson => dummyJson,
      AuthBackend.firebase => firebase,
      AuthBackend.supabase => supabase,
    };
  }
}
