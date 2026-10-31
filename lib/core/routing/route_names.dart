abstract final class RouteNames {
  static const splash = '/';

  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const resetPassword = '/reset-password';
  static const verifyOtp = '/verify-otp';
  static const verifyEmail = '/verify-email';

  static const dashboard = '/dashboard';
  static const profile = '/profile';
  static const uiShowcase = '/ui-showcase';
  static const products = '/products';
  static const apiHttpDemo = '/api-http-demo';
  static const firebaseCrudDemo = '/firebase-crud-demo';
  static const supabaseDemo = '/supabase-demo';
  static const authDemo = '/auth-demo';

  static const authRoutes = {
    login,
    register,
    forgotPassword,
    resetPassword,
    verifyOtp,
    verifyEmail,
  };
}
