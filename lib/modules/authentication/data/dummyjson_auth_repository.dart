import 'dart:async';

import 'package:abould_ada/core/constants/storage_keys.dart';
import 'package:abould_ada/core/errors/app_exception.dart';
import 'package:abould_ada/core/storage/secure_storage_service.dart';
import 'package:abould_ada/modules/api_integration/data/dummyjson_auth_api.dart';
import 'package:abould_ada/modules/authentication/domain/auth_exception.dart';
import 'package:abould_ada/modules/authentication/domain/auth_repository.dart';
import 'package:abould_ada/modules/authentication/domain/auth_user.dart';

class DummyJsonAuthRepository implements AuthRepository {
  DummyJsonAuthRepository({
    required DummyJsonAuthApi authApi,
    required SecureStorageService secureStorage,
  })  : _authApi = authApi,
        _secureStorage = secureStorage;

  final DummyJsonAuthApi _authApi;
  final SecureStorageService _secureStorage;
  final _controller = StreamController<AuthUser?>.broadcast();

  AuthUser? _currentUser;

  Future<void> initialize() => _restoreSession();

  Future<void> _restoreSession() async {
    final token = await _secureStorage.read(StorageKeys.accessToken);
    if (token == null || token.isEmpty) {
      _controller.add(null);
      return;
    }
    try {
      final data = await _authApi.getMe();
      _currentUser = _mapUser(data);
      _controller.add(_currentUser);
    } catch (_) {
      final restored = await _tryRefreshSession();
      if (!restored) {
        await _clearTokens();
        _controller.add(null);
      }
    }
  }

  @override
  Stream<AuthUser?> authStateChanges() => _controller.stream;

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) {
    return signInWithUsername(username: email.trim(), password: password);
  }

  Future<AuthUser> signInWithUsername({
    required String username,
    required String password,
  }) async {
    try {
      final data = await _authApi.login(username: username, password: password);
      final access = data['accessToken']?.toString();
      final refresh = data['refreshToken']?.toString();
      if (access == null || access.isEmpty) {
        throw const AuthFailure('Login failed: no access token returned.');
      }
      await _secureStorage.write(StorageKeys.accessToken, access);
      if (refresh != null) {
        await _secureStorage.write(StorageKeys.refreshToken, refresh);
      }
      _currentUser = _mapUser(data);
      _controller.add(_currentUser);
      return _currentUser!;
    } on AppException catch (e) {
      throw AuthFailure(e.message, code: e.code);
    }
  }

  AuthUser _mapUser(Map<String, dynamic> data) {
    final first = data['firstName']?.toString() ?? '';
    final last = data['lastName']?.toString() ?? '';
    final name = '$first $last'.trim();
    return AuthUser(
      id: data['id']?.toString() ?? '',
      email: data['email']?.toString() ?? data['username']?.toString() ?? '',
      displayName: name.isEmpty ? data['username']?.toString() : name,
      emailVerified: true,
    );
  }

  @override
  Future<AuthUser> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    throw const AuthFailure(
      'Registration is not available for DummyJSON demo API.',
    );
  }

  @override
  Future<void> sendEmailVerification() async {}

  @override
  Future<void> reloadUser() async {
    final data = await _authApi.getMe();
    _currentUser = _mapUser(data);
    _controller.add(_currentUser);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    throw const AuthFailure('Password reset is not supported on DummyJSON.');
  }

  @override
  Future<void> signOut() async {
    await _clearTokens();
    _currentUser = null;
    _controller.add(null);
  }

  Future<bool> _tryRefreshSession() async {
    final refresh = await _secureStorage.read(StorageKeys.refreshToken);
    if (refresh == null || refresh.isEmpty) {
      return false;
    }
    try {
      final data = await _authApi.refresh(refreshToken: refresh);
      final access = data['accessToken']?.toString();
      final newRefresh = data['refreshToken']?.toString();
      if (access == null || access.isEmpty) {
        return false;
      }
      await _secureStorage.write(StorageKeys.accessToken, access);
      if (newRefresh != null && newRefresh.isNotEmpty) {
        await _secureStorage.write(StorageKeys.refreshToken, newRefresh);
      }
      final me = await _authApi.getMe();
      _currentUser = _mapUser(me);
      _controller.add(_currentUser);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _clearTokens() async {
    await _secureStorage.delete(StorageKeys.accessToken);
    await _secureStorage.delete(StorageKeys.refreshToken);
  }
}
