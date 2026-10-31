import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Abould ADA'**
  String get appTitle;

  /// No description provided for @splashPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing your workspace…'**
  String get splashPreparing;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageHindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get languageHindi;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @emptyDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get emptyDefaultTitle;

  /// No description provided for @errorDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorDefaultTitle;

  /// No description provided for @errorDefaultMessage.
  ///
  /// In en, this message translates to:
  /// **'Please try again.'**
  String get errorDefaultMessage;

  /// No description provided for @dashboardStarterTitle.
  ///
  /// In en, this message translates to:
  /// **'Abould ADA Starter Kit'**
  String get dashboardStarterTitle;

  /// No description provided for @dashboardStarterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Build client apps faster with reusable modules, consistent UI, and tested integrations.'**
  String get dashboardStarterSubtitle;

  /// No description provided for @dashboardApi.
  ///
  /// In en, this message translates to:
  /// **'API'**
  String get dashboardApi;

  /// No description provided for @dashboardStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get dashboardStatus;

  /// No description provided for @dashboardStatusReady.
  ///
  /// In en, this message translates to:
  /// **'Core & modules ready'**
  String get dashboardStatusReady;

  /// No description provided for @dashboardPlatformModules.
  ///
  /// In en, this message translates to:
  /// **'Platform modules'**
  String get dashboardPlatformModules;

  /// No description provided for @dashboardTapModule.
  ///
  /// In en, this message translates to:
  /// **'Tap a module to open its demo'**
  String get dashboardTapModule;

  /// No description provided for @tileAuthentication.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get tileAuthentication;

  /// No description provided for @tileAuthenticationSub.
  ///
  /// In en, this message translates to:
  /// **'Login, OTP, sessions'**
  String get tileAuthenticationSub;

  /// No description provided for @tileApiIntegration.
  ///
  /// In en, this message translates to:
  /// **'API Integration'**
  String get tileApiIntegration;

  /// No description provided for @tileApiIntegrationSub.
  ///
  /// In en, this message translates to:
  /// **'Products GET + pagination'**
  String get tileApiIntegrationSub;

  /// No description provided for @tileHttpVerbs.
  ///
  /// In en, this message translates to:
  /// **'HTTP verbs'**
  String get tileHttpVerbs;

  /// No description provided for @tileHttpVerbsSub.
  ///
  /// In en, this message translates to:
  /// **'GET POST PUT PATCH DELETE'**
  String get tileHttpVerbsSub;

  /// No description provided for @tileFirestoreTodos.
  ///
  /// In en, this message translates to:
  /// **'Firestore todos'**
  String get tileFirestoreTodos;

  /// No description provided for @tileFirestoreTodosSub.
  ///
  /// In en, this message translates to:
  /// **'CRUD todo list in Firestore'**
  String get tileFirestoreTodosSub;

  /// No description provided for @tileSupabase.
  ///
  /// In en, this message translates to:
  /// **'Supabase'**
  String get tileSupabase;

  /// No description provided for @tileSupabaseSub.
  ///
  /// In en, this message translates to:
  /// **'Email auth, DB, realtime'**
  String get tileSupabaseSub;

  /// No description provided for @tileUiComponents.
  ///
  /// In en, this message translates to:
  /// **'UI Components'**
  String get tileUiComponents;

  /// No description provided for @tileUiComponentsSub.
  ///
  /// In en, this message translates to:
  /// **'Buttons, forms, dialogs'**
  String get tileUiComponentsSub;

  /// No description provided for @tileNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get tileNotifications;

  /// No description provided for @tileNotificationsSub.
  ///
  /// In en, this message translates to:
  /// **'Push & in-app alerts'**
  String get tileNotificationsSub;

  /// No description provided for @productsTitle.
  ///
  /// In en, this message translates to:
  /// **'Products (DummyJSON)'**
  String get productsTitle;

  /// No description provided for @searchLabel.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchLabel;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Type to search…'**
  String get searchHint;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found.'**
  String get noProductsFound;

  /// No description provided for @todosTitle.
  ///
  /// In en, this message translates to:
  /// **'Todos'**
  String get todosTitle;

  /// No description provided for @newTodoLabel.
  ///
  /// In en, this message translates to:
  /// **'New todo'**
  String get newTodoLabel;

  /// No description provided for @newTodoHint.
  ///
  /// In en, this message translates to:
  /// **'Task title'**
  String get newTodoHint;

  /// No description provided for @todoNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Todo name'**
  String get todoNameLabel;

  /// No description provided for @todoActiveSection.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get todoActiveSection;

  /// No description provided for @todoDoneSection.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get todoDoneSection;

  /// No description provided for @todoEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your list is empty'**
  String get todoEmptyTitle;

  /// No description provided for @todoEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a todo name above and tap + to add your first task.'**
  String get todoEmptyMessage;

  /// No description provided for @todoDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete todo?'**
  String get todoDeleteTitle;

  /// No description provided for @todoDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently removes “{name}”.'**
  String todoDeleteMessage(String name);

  /// No description provided for @todoDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete todo'**
  String get todoDeleteConfirm;

  /// No description provided for @todoDeleteCancel.
  ///
  /// In en, this message translates to:
  /// **'Keep todo'**
  String get todoDeleteCancel;

  /// No description provided for @todoEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit todo'**
  String get todoEditTitle;

  /// No description provided for @todoEditMessage.
  ///
  /// In en, this message translates to:
  /// **'Update the task name for this item.'**
  String get todoEditMessage;

  /// No description provided for @todoAddFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not add todo: {error}'**
  String todoAddFailed(String error);

  /// No description provided for @todoDeleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Delete failed: {error}'**
  String todoDeleteFailed(String error);

  /// No description provided for @todoUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Update failed: {error}'**
  String todoUpdateFailed(String error);

  /// No description provided for @uiLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'UI Component Library'**
  String get uiLibraryTitle;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @registerWith.
  ///
  /// In en, this message translates to:
  /// **'Register with'**
  String get registerWith;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @workEmail.
  ///
  /// In en, this message translates to:
  /// **'Work email'**
  String get workEmail;

  /// No description provided for @phoneOptional.
  ///
  /// In en, this message translates to:
  /// **'Phone (optional)'**
  String get phoneOptional;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @acceptTermsPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms to continue.'**
  String get acceptTermsPrompt;

  /// No description provided for @createAccountButton.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountButton;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Register with Firebase or Supabase. API login is sign-in only.'**
  String get registerSubtitle;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @newToAda.
  ///
  /// In en, this message translates to:
  /// **'New to ADA?'**
  String get newToAda;

  /// No description provided for @createAccountLink.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccountLink;

  /// No description provided for @loginSubtitleApi.
  ///
  /// In en, this message translates to:
  /// **'API login uses DummyJSON (e.g. emilys / emilyspass).'**
  String get loginSubtitleApi;

  /// No description provided for @loginSubtitleFirebase.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your Firebase email and password.'**
  String get loginSubtitleFirebase;

  /// No description provided for @loginSubtitleSupabase.
  ///
  /// In en, this message translates to:
  /// **'Sign in with your Supabase project credentials.'**
  String get loginSubtitleSupabase;

  /// No description provided for @usernameOrEmail.
  ///
  /// In en, this message translates to:
  /// **'Username or email'**
  String get usernameOrEmail;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @signInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed. Please try again.'**
  String get signInFailed;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again.'**
  String get registrationFailed;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We will send a reset link to your email.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send reset link'**
  String get sendResetLink;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPasswordTitle;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPassword;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update password'**
  String get updatePassword;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get verifyEmailTitle;

  /// No description provided for @verifyOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get verifyOtpTitle;

  /// No description provided for @otpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the code we sent to your phone or email.'**
  String get otpSubtitle;

  /// No description provided for @verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyButton;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @demoUser.
  ///
  /// In en, this message translates to:
  /// **'Demo User'**
  String get demoUser;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @notificationsSettings.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsSettings;

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & security'**
  String get privacySecurity;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get helpSupport;

  /// No description provided for @locationTitle.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationTitle;

  /// No description provided for @locationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission denied.'**
  String get locationPermissionDenied;

  /// No description provided for @locationFetchFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not read GPS location.'**
  String get locationFetchFailed;

  /// No description provided for @locationRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh location'**
  String get locationRefresh;

  /// No description provided for @locationLatitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get locationLatitude;

  /// No description provided for @locationLongitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get locationLongitude;

  /// No description provided for @appLifecycleTitle.
  ///
  /// In en, this message translates to:
  /// **'App lifecycle'**
  String get appLifecycleTitle;

  /// No description provided for @lifecycleState.
  ///
  /// In en, this message translates to:
  /// **'Current state'**
  String get lifecycleState;

  /// No description provided for @supabaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Supabase'**
  String get supabaseTitle;

  /// No description provided for @supabaseProjectConnection.
  ///
  /// In en, this message translates to:
  /// **'Project connection'**
  String get supabaseProjectConnection;

  /// No description provided for @supabaseSdkConnected.
  ///
  /// In en, this message translates to:
  /// **'SDK connected'**
  String get supabaseSdkConnected;

  /// No description provided for @supabaseNotInitialized.
  ///
  /// In en, this message translates to:
  /// **'Not initialized'**
  String get supabaseNotInitialized;

  /// No description provided for @supabaseKeysProvided.
  ///
  /// In en, this message translates to:
  /// **'Keys provided'**
  String get supabaseKeysProvided;

  /// No description provided for @supabaseKeysMissing.
  ///
  /// In en, this message translates to:
  /// **'Keys missing'**
  String get supabaseKeysMissing;

  /// No description provided for @supabaseRealtimeCrud.
  ///
  /// In en, this message translates to:
  /// **'Realtime CRUD active'**
  String get supabaseRealtimeCrud;

  /// No description provided for @supabaseAuthSection.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get supabaseAuthSection;

  /// No description provided for @supabaseSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {email}'**
  String supabaseSignedInAs(String email);

  /// No description provided for @supabaseSignInHint.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Supabase to use Realtime CRUD.'**
  String get supabaseSignInHint;

  /// No description provided for @supabaseKeysHint.
  ///
  /// In en, this message translates to:
  /// **'Add publishable/anon key and restart the app.'**
  String get supabaseKeysHint;

  /// No description provided for @supabaseOpenLogin.
  ///
  /// In en, this message translates to:
  /// **'Open login (Supabase)'**
  String get supabaseOpenLogin;

  /// No description provided for @supabaseCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account (Supabase)'**
  String get supabaseCreateAccount;

  /// No description provided for @supabaseUserTable.
  ///
  /// In en, this message translates to:
  /// **'User (profiles table)'**
  String get supabaseUserTable;

  /// No description provided for @supabaseUserId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get supabaseUserId;

  /// No description provided for @supabaseEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get supabaseEmail;

  /// No description provided for @supabaseFullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get supabaseFullName;

  /// No description provided for @supabaseProfileCreated.
  ///
  /// In en, this message translates to:
  /// **'Profile created'**
  String get supabaseProfileCreated;

  /// No description provided for @supabaseRealtimeTasks.
  ///
  /// In en, this message translates to:
  /// **'Realtime tasks'**
  String get supabaseRealtimeTasks;

  /// No description provided for @authDemoTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication'**
  String get authDemoTitle;

  /// No description provided for @apiHttpDemoTitle.
  ///
  /// In en, this message translates to:
  /// **'HTTP verbs (DummyJSON Users)'**
  String get apiHttpDemoTitle;

  /// No description provided for @firebasePanelTitle.
  ///
  /// In en, this message translates to:
  /// **'Firebase workspace'**
  String get firebasePanelTitle;

  /// No description provided for @fcmToken.
  ///
  /// In en, this message translates to:
  /// **'FCM token'**
  String get fcmToken;

  /// No description provided for @firestoreWelcome.
  ///
  /// In en, this message translates to:
  /// **'Firestore connected.'**
  String get firestoreWelcome;

  /// No description provided for @labelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelEmail;

  /// No description provided for @labelPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get labelPhone;

  /// No description provided for @labelNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get labelNotes;

  /// No description provided for @showcaseButtons.
  ///
  /// In en, this message translates to:
  /// **'Buttons'**
  String get showcaseButtons;

  /// No description provided for @showcaseButtonsSub.
  ///
  /// In en, this message translates to:
  /// **'Primary, secondary, outlined, text, icon, loading, disabled'**
  String get showcaseButtonsSub;

  /// No description provided for @showcaseInputs.
  ///
  /// In en, this message translates to:
  /// **'Inputs'**
  String get showcaseInputs;

  /// No description provided for @showcaseInputsSub.
  ///
  /// In en, this message translates to:
  /// **'Fields, pickers, dropdowns, checkbox, radio, switch'**
  String get showcaseInputsSub;

  /// No description provided for @showcaseNavigation.
  ///
  /// In en, this message translates to:
  /// **'Navigation'**
  String get showcaseNavigation;

  /// No description provided for @showcaseNavigationSub.
  ///
  /// In en, this message translates to:
  /// **'App bar, tabs, drawer, bottom bar'**
  String get showcaseNavigationSub;

  /// No description provided for @showcaseDisplay.
  ///
  /// In en, this message translates to:
  /// **'Display'**
  String get showcaseDisplay;

  /// No description provided for @showcaseDisplaySub.
  ///
  /// In en, this message translates to:
  /// **'Cards, badges, progress, rating, avatars'**
  String get showcaseDisplaySub;

  /// No description provided for @showcaseFeedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get showcaseFeedback;

  /// No description provided for @showcaseFeedbackSub.
  ///
  /// In en, this message translates to:
  /// **'Dialogs, sheets, snackbars, shimmer, empty & error'**
  String get showcaseFeedbackSub;

  /// No description provided for @showcaseMedia.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get showcaseMedia;

  /// No description provided for @showcaseMediaSub.
  ///
  /// In en, this message translates to:
  /// **'Image pickers, gallery, documents, video'**
  String get showcaseMediaSub;

  /// No description provided for @showcaseTokens.
  ///
  /// In en, this message translates to:
  /// **'Design tokens'**
  String get showcaseTokens;

  /// No description provided for @showcaseTokensSub.
  ///
  /// In en, this message translates to:
  /// **'Brand colors, radius, spacing'**
  String get showcaseTokensSub;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @avatarUploadSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in to upload an avatar.'**
  String get avatarUploadSignIn;

  /// No description provided for @avatarUploadFirebaseOff.
  ///
  /// In en, this message translates to:
  /// **'Firebase is disabled in this build.'**
  String get avatarUploadFirebaseOff;

  /// No description provided for @avatarUploadSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile photo updated.'**
  String get avatarUploadSuccess;

  /// No description provided for @avatarUploadFailed.
  ///
  /// In en, this message translates to:
  /// **'Upload failed: {error}'**
  String avatarUploadFailed(String error);

  /// No description provided for @labelUsername.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get labelUsername;

  /// No description provided for @hintUsernameApi.
  ///
  /// In en, this message translates to:
  /// **'emilys'**
  String get hintUsernameApi;

  /// No description provided for @hintEmailWork.
  ///
  /// In en, this message translates to:
  /// **'you@company.com'**
  String get hintEmailWork;

  /// No description provided for @passwordHintEnter.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHintEnter;

  /// No description provided for @passwordHintMin.
  ///
  /// In en, this message translates to:
  /// **'Min. 8 characters'**
  String get passwordHintMin;

  /// No description provided for @hintFullName.
  ///
  /// In en, this message translates to:
  /// **'Jane Developer'**
  String get hintFullName;

  /// No description provided for @hintPhoneIndia.
  ///
  /// In en, this message translates to:
  /// **'+91 98765 43210'**
  String get hintPhoneIndia;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms of Service and Privacy Policy.'**
  String get termsAgreement;

  /// No description provided for @loginSupabaseRegNote.
  ///
  /// In en, this message translates to:
  /// **'Registration is available via Supabase on the create-account screen.'**
  String get loginSupabaseRegNote;

  /// No description provided for @profileProjects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get profileProjects;

  /// No description provided for @profileTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get profileTasks;

  /// No description provided for @profileAlerts.
  ///
  /// In en, this message translates to:
  /// **'Alerts'**
  String get profileAlerts;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account settings'**
  String get accountSettings;

  /// No description provided for @securityTitle.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get securityTitle;

  /// No description provided for @securitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Password, 2FA, sessions'**
  String get securitySubtitle;

  /// No description provided for @appearanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceTitle;

  /// No description provided for @appearanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Theme follows system setting'**
  String get appearanceSubtitle;

  /// No description provided for @editProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Available after auth module'**
  String get editProfileSubtitle;

  /// No description provided for @profileReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile ready'**
  String get profileReadyTitle;

  /// No description provided for @profileReadyMessage.
  ///
  /// In en, this message translates to:
  /// **'Firebase Authentication is connected. More profile fields will appear as features are added.'**
  String get profileReadyMessage;

  /// No description provided for @verifyEmailProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get verifyEmailProfileTitle;

  /// No description provided for @verifyEmailProfileMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your inbox for the Firebase verification link, or open Email verification from registration.'**
  String get verifyEmailProfileMessage;

  /// No description provided for @supabaseUrlMissingConfig.
  ///
  /// In en, this message translates to:
  /// **'Set SUPABASE_URL in dart_defines/supabase.local.json'**
  String get supabaseUrlMissingConfig;

  /// No description provided for @supabaseSetupSteps.
  ///
  /// In en, this message translates to:
  /// **'1) Run SQL: supabase/migrations/001_ada_tasks.sql\n2) Auth → Email provider (confirm email optional)\n3) Sign in with Supabase below, then use Realtime tasks'**
  String get supabaseSetupSteps;

  /// No description provided for @supabaseSignInCrudHint.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Supabase to use Realtime CRUD (RLS uses auth.uid()).'**
  String get supabaseSignInCrudHint;

  /// No description provided for @supabaseCrudUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Session is Supabase but CRUD is unavailable. Check SQL migration and Realtime publication for ada_tasks.'**
  String get supabaseCrudUnavailable;

  /// No description provided for @urlLabel.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get urlLabel;

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get backToSignIn;

  /// No description provided for @passwordUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password updated successfully.'**
  String get passwordUpdatedSuccess;

  /// No description provided for @otpCodeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the 6-digit code.'**
  String get otpCodeRequired;

  /// No description provided for @otpVerifiedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Phone/email verified. You can sign in.'**
  String get otpVerifiedSuccess;

  /// No description provided for @verifyEmailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We sent a confirmation link to {email}.'**
  String verifyEmailSubtitle(String email);

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'We sent a 6-digit code to {email}'**
  String otpSentTo(String email);

  /// No description provided for @setNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set new password'**
  String get setNewPasswordTitle;

  /// No description provided for @passwordResetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent. Check your inbox.'**
  String get passwordResetEmailSent;

  /// No description provided for @forgotPasswordInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and Firebase will send a link to reset your password.'**
  String get forgotPasswordInstructions;

  /// No description provided for @verifyEmailCheckInbox.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get verifyEmailCheckInbox;

  /// No description provided for @verifyEmailInstructions.
  ///
  /// In en, this message translates to:
  /// **'Tap the link in the Firebase verification email, then press \"I\'ve verified\" below.'**
  String get verifyEmailInstructions;

  /// No description provided for @emailVerifiedButton.
  ///
  /// In en, this message translates to:
  /// **'I\'ve verified my email'**
  String get emailVerifiedButton;

  /// No description provided for @resendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend email'**
  String get resendEmail;

  /// No description provided for @verificationEmailSentAgain.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent again.'**
  String get verificationEmailSentAgain;

  /// No description provided for @emailVerifiedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Email verified successfully.'**
  String get emailVerifiedSuccess;

  /// No description provided for @emailNotVerifiedYet.
  ///
  /// In en, this message translates to:
  /// **'Email not verified yet. Open the link in your inbox.'**
  String get emailNotVerifiedYet;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm new password'**
  String get confirmNewPassword;

  /// No description provided for @resetPasswordSubtitleEmail.
  ///
  /// In en, this message translates to:
  /// **'Create a new password for {email}'**
  String resetPasswordSubtitleEmail(String email);

  /// No description provided for @resetPasswordSubtitleGeneric.
  ///
  /// In en, this message translates to:
  /// **'Choose a strong password for your account.'**
  String get resetPasswordSubtitleGeneric;

  /// No description provided for @otpDemoHint.
  ///
  /// In en, this message translates to:
  /// **'Demo code: use any 6 digits to continue.'**
  String get otpDemoHint;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {seconds}s'**
  String resendCodeIn(int seconds);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
