abstract final class DummyJsonEndpoints {
  static const login = '/auth/login';
  static const me = '/auth/me';
  static const refresh = '/auth/refresh';
  static const products = '/products';
  static const productsSearch = '/products/search';

  static const users = '/users';
  static const usersAdd = '/users/add';
  static const usersSearch = '/users/search';
  static const usersFilter = '/users/filter';

  static String userById(int id) => '/users/$id';
}
