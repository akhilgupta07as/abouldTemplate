// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Abould ADA';

  @override
  String get splashPreparing => 'Preparing your workspace…';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get signOut => 'Sign out';

  @override
  String get signIn => 'Sign in';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get retry => 'Retry';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get close => 'Close';

  @override
  String get emptyDefaultTitle => 'Nothing here yet';

  @override
  String get errorDefaultTitle => 'Something went wrong';

  @override
  String get errorDefaultMessage => 'Please try again.';

  @override
  String get dashboardStarterTitle => 'Abould ADA Starter Kit';

  @override
  String get dashboardStarterSubtitle =>
      'Build client apps faster with reusable modules, consistent UI, and tested integrations.';

  @override
  String get dashboardApi => 'API';

  @override
  String get dashboardStatus => 'Status';

  @override
  String get dashboardStatusReady => 'Core & modules ready';

  @override
  String get dashboardPlatformModules => 'Platform modules';

  @override
  String get dashboardTapModule => 'Tap a module to open its demo';

  @override
  String get tileAuthentication => 'Authentication';

  @override
  String get tileAuthenticationSub => 'Login, OTP, sessions';

  @override
  String get tileApiIntegration => 'API Integration';

  @override
  String get tileApiIntegrationSub => 'Products GET + pagination';

  @override
  String get tileHttpVerbs => 'HTTP verbs';

  @override
  String get tileHttpVerbsSub => 'GET POST PUT PATCH DELETE';

  @override
  String get tileFirestoreTodos => 'Firestore todos';

  @override
  String get tileFirestoreTodosSub => 'CRUD todo list in Firestore';

  @override
  String get tileSupabase => 'Supabase';

  @override
  String get tileSupabaseSub => 'Email auth, DB, realtime';

  @override
  String get tileUiComponents => 'UI Components';

  @override
  String get tileUiComponentsSub => 'Buttons, forms, dialogs';

  @override
  String get tileNotifications => 'Notifications';

  @override
  String get tileNotificationsSub => 'Push & in-app alerts';

  @override
  String get productsTitle => 'Products (DummyJSON)';

  @override
  String get searchLabel => 'Search';

  @override
  String get searchHint => 'Type to search…';

  @override
  String get noProductsFound => 'No products found.';

  @override
  String get todosTitle => 'Todos';

  @override
  String get newTodoLabel => 'New todo';

  @override
  String get newTodoHint => 'Task title';

  @override
  String get todoNameLabel => 'Todo name';

  @override
  String get todoActiveSection => 'Active';

  @override
  String get todoDoneSection => 'Done';

  @override
  String get todoEmptyTitle => 'Your list is empty';

  @override
  String get todoEmptyMessage =>
      'Type a todo name above and tap + to add your first task.';

  @override
  String get todoDeleteTitle => 'Delete todo?';

  @override
  String todoDeleteMessage(String name) {
    return 'This permanently removes “$name”.';
  }

  @override
  String get todoDeleteConfirm => 'Delete todo';

  @override
  String get todoDeleteCancel => 'Keep todo';

  @override
  String get todoEditTitle => 'Edit todo';

  @override
  String get todoEditMessage => 'Update the task name for this item.';

  @override
  String todoAddFailed(String error) {
    return 'Could not add todo: $error';
  }

  @override
  String todoDeleteFailed(String error) {
    return 'Delete failed: $error';
  }

  @override
  String todoUpdateFailed(String error) {
    return 'Update failed: $error';
  }

  @override
  String get uiLibraryTitle => 'UI Component Library';

  @override
  String get createAccount => 'Create account';

  @override
  String get registerWith => 'Register with';

  @override
  String get fullName => 'Full name';

  @override
  String get workEmail => 'Work email';

  @override
  String get phoneOptional => 'Phone (optional)';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get acceptTermsPrompt => 'Please accept the terms to continue.';

  @override
  String get createAccountButton => 'Create account';

  @override
  String get registerSubtitle =>
      'Register with Firebase or Supabase. API login is sign-in only.';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get newToAda => 'New to ADA?';

  @override
  String get createAccountLink => 'Create account';

  @override
  String get loginSubtitleApi =>
      'API login uses DummyJSON (e.g. emilys / emilyspass).';

  @override
  String get loginSubtitleFirebase =>
      'Sign in with your Firebase email and password.';

  @override
  String get loginSubtitleSupabase =>
      'Sign in with your Supabase project credentials.';

  @override
  String get usernameOrEmail => 'Username or email';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get signInFailed => 'Sign in failed. Please try again.';

  @override
  String get registrationFailed => 'Registration failed. Please try again.';

  @override
  String get forgotPasswordTitle => 'Forgot password?';

  @override
  String get forgotPasswordSubtitle =>
      'We will send a reset link to your email.';

  @override
  String get sendResetLink => 'Send reset link';

  @override
  String get resetPasswordTitle => 'Reset password';

  @override
  String get newPassword => 'New password';

  @override
  String get updatePassword => 'Update password';

  @override
  String get verifyEmailTitle => 'Verify your email';

  @override
  String get verifyOtpTitle => 'Enter verification code';

  @override
  String get otpSubtitle => 'Enter the code we sent to your phone or email.';

  @override
  String get verifyButton => 'Verify';

  @override
  String get resendCode => 'Resend code';

  @override
  String get profileTitle => 'Profile';

  @override
  String get demoUser => 'Demo User';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get notificationsSettings => 'Notifications';

  @override
  String get privacySecurity => 'Privacy & security';

  @override
  String get helpSupport => 'Help & support';

  @override
  String get locationTitle => 'Location';

  @override
  String get locationPermissionDenied => 'Location permission denied.';

  @override
  String get locationFetchFailed => 'Could not read GPS location.';

  @override
  String get locationRefresh => 'Refresh location';

  @override
  String get locationLatitude => 'Latitude';

  @override
  String get locationLongitude => 'Longitude';

  @override
  String get appLifecycleTitle => 'App lifecycle';

  @override
  String get lifecycleState => 'Current state';

  @override
  String get supabaseTitle => 'Supabase';

  @override
  String get supabaseProjectConnection => 'Project connection';

  @override
  String get supabaseSdkConnected => 'SDK connected';

  @override
  String get supabaseNotInitialized => 'Not initialized';

  @override
  String get supabaseKeysProvided => 'Keys provided';

  @override
  String get supabaseKeysMissing => 'Keys missing';

  @override
  String get supabaseRealtimeCrud => 'Realtime CRUD active';

  @override
  String get supabaseAuthSection => 'Authentication';

  @override
  String supabaseSignedInAs(String email) {
    return 'Signed in as $email';
  }

  @override
  String get supabaseSignInHint =>
      'Sign in with Supabase to use Realtime CRUD.';

  @override
  String get supabaseKeysHint =>
      'Add publishable/anon key and restart the app.';

  @override
  String get supabaseOpenLogin => 'Open login (Supabase)';

  @override
  String get supabaseCreateAccount => 'Create account (Supabase)';

  @override
  String get supabaseUserTable => 'User (profiles table)';

  @override
  String get supabaseUserId => 'User ID';

  @override
  String get supabaseEmail => 'Email';

  @override
  String get supabaseFullName => 'Full name';

  @override
  String get supabaseProfileCreated => 'Profile created';

  @override
  String get supabaseRealtimeTasks => 'Realtime tasks';

  @override
  String get authDemoTitle => 'Authentication';

  @override
  String get apiHttpDemoTitle => 'HTTP verbs (DummyJSON Users)';

  @override
  String get firebasePanelTitle => 'Firebase workspace';

  @override
  String get fcmToken => 'FCM token';

  @override
  String get firestoreWelcome => 'Firestore connected.';

  @override
  String get labelEmail => 'Email';

  @override
  String get labelPhone => 'Phone';

  @override
  String get labelNotes => 'Notes';

  @override
  String get showcaseButtons => 'Buttons';

  @override
  String get showcaseButtonsSub =>
      'Primary, secondary, outlined, text, icon, loading, disabled';

  @override
  String get showcaseInputs => 'Inputs';

  @override
  String get showcaseInputsSub =>
      'Fields, pickers, dropdowns, checkbox, radio, switch';

  @override
  String get showcaseNavigation => 'Navigation';

  @override
  String get showcaseNavigationSub => 'App bar, tabs, drawer, bottom bar';

  @override
  String get showcaseDisplay => 'Display';

  @override
  String get showcaseDisplaySub => 'Cards, badges, progress, rating, avatars';

  @override
  String get showcaseFeedback => 'Feedback';

  @override
  String get showcaseFeedbackSub =>
      'Dialogs, sheets, snackbars, shimmer, empty & error';

  @override
  String get showcaseMedia => 'Media';

  @override
  String get showcaseMediaSub => 'Image pickers, gallery, documents, video';

  @override
  String get showcaseTokens => 'Design tokens';

  @override
  String get showcaseTokensSub => 'Brand colors, radius, spacing';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get avatarUploadSignIn => 'Sign in to upload an avatar.';

  @override
  String get avatarUploadFirebaseOff => 'Firebase is disabled in this build.';

  @override
  String get avatarUploadSuccess => 'Profile photo updated.';

  @override
  String avatarUploadFailed(String error) {
    return 'Upload failed: $error';
  }

  @override
  String get labelUsername => 'Username';

  @override
  String get hintUsernameApi => 'emilys';

  @override
  String get hintEmailWork => 'you@company.com';

  @override
  String get passwordHintEnter => 'Enter your password';

  @override
  String get passwordHintMin => 'Min. 8 characters';

  @override
  String get hintFullName => 'Jane Developer';

  @override
  String get hintPhoneIndia => '+91 98765 43210';

  @override
  String get termsAgreement =>
      'I agree to the Terms of Service and Privacy Policy.';

  @override
  String get loginSupabaseRegNote =>
      'Registration is available via Supabase on the create-account screen.';

  @override
  String get profileProjects => 'Projects';

  @override
  String get profileTasks => 'Tasks';

  @override
  String get profileAlerts => 'Alerts';

  @override
  String get accountSettings => 'Account settings';

  @override
  String get securityTitle => 'Security';

  @override
  String get securitySubtitle => 'Password, 2FA, sessions';

  @override
  String get appearanceTitle => 'Appearance';

  @override
  String get appearanceSubtitle => 'Theme follows system setting';

  @override
  String get editProfileSubtitle => 'Available after auth module';

  @override
  String get profileReadyTitle => 'Profile ready';

  @override
  String get profileReadyMessage =>
      'Firebase Authentication is connected. More profile fields will appear as features are added.';

  @override
  String get verifyEmailProfileTitle => 'Verify your email';

  @override
  String get verifyEmailProfileMessage =>
      'Check your inbox for the Firebase verification link, or open Email verification from registration.';

  @override
  String get supabaseUrlMissingConfig =>
      'Set SUPABASE_URL in dart_defines/supabase.local.json';

  @override
  String get supabaseSetupSteps =>
      '1) Run SQL: supabase/migrations/001_ada_tasks.sql\n2) Auth → Email provider (confirm email optional)\n3) Sign in with Supabase below, then use Realtime tasks';

  @override
  String get supabaseSignInCrudHint =>
      'Sign in with Supabase to use Realtime CRUD (RLS uses auth.uid()).';

  @override
  String get supabaseCrudUnavailable =>
      'Session is Supabase but CRUD is unavailable. Check SQL migration and Realtime publication for ada_tasks.';

  @override
  String get urlLabel => 'URL';

  @override
  String get backToSignIn => 'Back to sign in';

  @override
  String get passwordUpdatedSuccess => 'Password updated successfully.';

  @override
  String get otpCodeRequired => 'Please enter the 6-digit code.';

  @override
  String get otpVerifiedSuccess => 'Phone/email verified. You can sign in.';

  @override
  String verifyEmailSubtitle(String email) {
    return 'We sent a confirmation link to $email.';
  }

  @override
  String otpSentTo(String email) {
    return 'We sent a 6-digit code to $email';
  }

  @override
  String get setNewPasswordTitle => 'Set new password';

  @override
  String get passwordResetEmailSent =>
      'Password reset email sent. Check your inbox.';

  @override
  String get forgotPasswordInstructions =>
      'Enter your email and Firebase will send a link to reset your password.';

  @override
  String get verifyEmailCheckInbox => 'Check your email';

  @override
  String get verifyEmailInstructions =>
      'Tap the link in the Firebase verification email, then press \"I\'ve verified\" below.';

  @override
  String get emailVerifiedButton => 'I\'ve verified my email';

  @override
  String get resendEmail => 'Resend email';

  @override
  String get verificationEmailSentAgain => 'Verification email sent again.';

  @override
  String get emailVerifiedSuccess => 'Email verified successfully.';

  @override
  String get emailNotVerifiedYet =>
      'Email not verified yet. Open the link in your inbox.';

  @override
  String get confirmNewPassword => 'Confirm new password';

  @override
  String resetPasswordSubtitleEmail(String email) {
    return 'Create a new password for $email';
  }

  @override
  String get resetPasswordSubtitleGeneric =>
      'Choose a strong password for your account.';

  @override
  String get otpDemoHint => 'Demo code: use any 6 digits to continue.';

  @override
  String resendCodeIn(int seconds) {
    return 'Resend code in ${seconds}s';
  }
}
