abstract final class FirestorePaths {
  static String workspaceConfig(String uid) => 'users/$uid/workspace/config';

  static String userProfile(String uid) => 'users/$uid/profile';

  static String userAvatarStorage(String uid) => 'users/$uid/avatars/profile.jpg';

  /// Flat todo collection (not nested under user documents).
  static const todosCollection = 'todo';

  static String todoDocument(String todoId) => 'todo/$todoId';
}
