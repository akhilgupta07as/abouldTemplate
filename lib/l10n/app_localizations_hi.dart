// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Abould ADA';

  @override
  String get splashPreparing => 'आपका वर्कस्पेस तैयार हो रहा है…';

  @override
  String get welcomeBack => 'वापसी पर स्वागत है';

  @override
  String get signOut => 'साइन आउट';

  @override
  String get signIn => 'साइन इन';

  @override
  String get languageLabel => 'भाषा';

  @override
  String get languageEnglish => 'अंग्रेज़ी';

  @override
  String get languageHindi => 'हिन्दी';

  @override
  String get retry => 'पुनः प्रयास';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get save => 'सहेजें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get edit => 'संपादित करें';

  @override
  String get close => 'बंद करें';

  @override
  String get emptyDefaultTitle => 'यहाँ अभी कुछ नहीं है';

  @override
  String get errorDefaultTitle => 'कुछ गलत हो गया';

  @override
  String get errorDefaultMessage => 'कृपया पुनः प्रयास करें।';

  @override
  String get dashboardStarterTitle => 'Abould ADA स्टार्टर किट';

  @override
  String get dashboardStarterSubtitle =>
      'पुन: प्रयोज्य मॉड्यूल, एक जैसा UI और जाँचे हुए इंटीग्रेशन से क्लाइंट ऐप तेज़ बनाएँ।';

  @override
  String get dashboardApi => 'API';

  @override
  String get dashboardStatus => 'स्थिति';

  @override
  String get dashboardStatusReady => 'कोर और मॉड्यूल तैयार';

  @override
  String get dashboardPlatformModules => 'प्लेटफ़ॉर्म मॉड्यूल';

  @override
  String get dashboardTapModule => 'डेमो खोलने के लिए किसी मॉड्यूल पर टैप करें';

  @override
  String get tileAuthentication => 'प्रमाणीकरण';

  @override
  String get tileAuthenticationSub => 'लॉगिन, OTP, सत्र';

  @override
  String get tileApiIntegration => 'API इंटीग्रेशन';

  @override
  String get tileApiIntegrationSub => 'Products GET + पेजिनेशन';

  @override
  String get tileHttpVerbs => 'HTTP verbs';

  @override
  String get tileHttpVerbsSub => 'GET POST PUT PATCH DELETE';

  @override
  String get tileFirestoreTodos => 'Firestore todos';

  @override
  String get tileFirestoreTodosSub => 'Firestore में CRUD todo सूची';

  @override
  String get tileSupabase => 'Supabase';

  @override
  String get tileSupabaseSub => 'ईमेल auth, DB, realtime';

  @override
  String get tileUiComponents => 'UI कंपोनेंट';

  @override
  String get tileUiComponentsSub => 'बटन, फ़ॉर्म, डायलॉग';

  @override
  String get tileNotifications => 'सूचनाएँ';

  @override
  String get tileNotificationsSub => 'Push और in-app अलर्ट';

  @override
  String get productsTitle => 'Products (DummyJSON)';

  @override
  String get searchLabel => 'खोजें';

  @override
  String get searchHint => 'खोजने के लिए लिखें…';

  @override
  String get noProductsFound => 'कोई प्रोडक्ट नहीं मिला।';

  @override
  String get todosTitle => 'Todos';

  @override
  String get newTodoLabel => 'नया todo';

  @override
  String get newTodoHint => 'कार्य का शीर्षक';

  @override
  String get todoNameLabel => 'Todo नाम';

  @override
  String get todoActiveSection => 'सक्रिय';

  @override
  String get todoDoneSection => 'पूर्ण';

  @override
  String get todoEmptyTitle => 'आपकी सूची खाली है';

  @override
  String get todoEmptyMessage =>
      'ऊपर todo नाम लिखें और + दबाकर पहला कार्य जोड़ें।';

  @override
  String get todoDeleteTitle => 'Todo हटाएँ?';

  @override
  String todoDeleteMessage(String name) {
    return 'यह “$name” को स्थायी रूप से हटा देगा।';
  }

  @override
  String get todoDeleteConfirm => 'Todo हटाएँ';

  @override
  String get todoDeleteCancel => 'Todo रखें';

  @override
  String get todoEditTitle => 'Todo संपादित करें';

  @override
  String get todoEditMessage => 'इस आइटम के लिए कार्य का नाम अपडेट करें।';

  @override
  String todoAddFailed(String error) {
    return 'Todo जोड़ नहीं सका: $error';
  }

  @override
  String todoDeleteFailed(String error) {
    return 'हटाना विफल: $error';
  }

  @override
  String todoUpdateFailed(String error) {
    return 'अपडेट विफल: $error';
  }

  @override
  String get uiLibraryTitle => 'UI Component Library';

  @override
  String get createAccount => 'खाता बनाएँ';

  @override
  String get registerWith => 'इसके साथ पंजीकरण';

  @override
  String get fullName => 'पूरा नाम';

  @override
  String get workEmail => 'कार्य ईमेल';

  @override
  String get phoneOptional => 'फ़ोन (वैकल्पिक)';

  @override
  String get password => 'पासवर्ड';

  @override
  String get confirmPassword => 'पासवर्ड की पुष्टि';

  @override
  String get acceptTermsPrompt => 'जारी रखने के लिए नियम स्वीकार करें।';

  @override
  String get createAccountButton => 'खाता बनाएँ';

  @override
  String get registerSubtitle =>
      'Firebase या Supabase से पंजीकरण। API केवल साइन-इन के लिए।';

  @override
  String get alreadyHaveAccount => 'पहले से खाता है?';

  @override
  String get newToAda => 'ADA में नए हैं?';

  @override
  String get createAccountLink => 'खाता बनाएँ';

  @override
  String get loginSubtitleApi =>
      'API लॉगिन DummyJSON उपयोग करता है (जैसे emilys / emilyspass)।';

  @override
  String get loginSubtitleFirebase =>
      'Firebase ईमेल और पासवर्ड से साइन इन करें।';

  @override
  String get loginSubtitleSupabase =>
      'Supabase प्रोजेक्ट क्रेडेंशियल से साइन इन करें।';

  @override
  String get usernameOrEmail => 'उपयोगकर्ता नाम या ईमेल';

  @override
  String get rememberMe => 'मुझे याद रखें';

  @override
  String get signInFailed => 'साइन इन विफल। पुनः प्रयास करें।';

  @override
  String get registrationFailed => 'पंजीकरण विफल। पुनः प्रयास करें।';

  @override
  String get forgotPasswordTitle => 'पासवर्ड भूल गए?';

  @override
  String get forgotPasswordSubtitle => 'हम आपके ईमेल पर रीसेट लिंक भेजेंगे।';

  @override
  String get sendResetLink => 'रीसेट लिंक भेजें';

  @override
  String get resetPasswordTitle => 'पासवर्ड रीसेट';

  @override
  String get newPassword => 'नया पासवर्ड';

  @override
  String get updatePassword => 'पासवर्ड अपडेट करें';

  @override
  String get verifyEmailTitle => 'अपना ईमेल सत्यापित करें';

  @override
  String get verifyOtpTitle => 'सत्यापन कोड दर्ज करें';

  @override
  String get otpSubtitle => 'फ़ोन या ईमेल पर भेजा गया कोड दर्ज करें।';

  @override
  String get verifyButton => 'सत्यापित करें';

  @override
  String get resendCode => 'कोड पुनः भेजें';

  @override
  String get profileTitle => 'प्रोफ़ाइल';

  @override
  String get demoUser => 'डेमो उपयोगकर्ता';

  @override
  String get editProfile => 'प्रोफ़ाइल संपादित करें';

  @override
  String get notificationsSettings => 'सूचनाएँ';

  @override
  String get privacySecurity => 'गोपनीयता और सुरक्षा';

  @override
  String get helpSupport => 'सहायता और समर्थन';

  @override
  String get locationTitle => 'स्थान';

  @override
  String get locationPermissionDenied => 'स्थान अनुमति अस्वीकृत।';

  @override
  String get locationFetchFailed => 'GPS स्थान नहीं पढ़ सका।';

  @override
  String get locationRefresh => 'स्थान रीफ़्रेश करें';

  @override
  String get locationLatitude => 'अक्षांश';

  @override
  String get locationLongitude => 'देशांतर';

  @override
  String get appLifecycleTitle => 'ऐप जीवनचक्र';

  @override
  String get lifecycleState => 'वर्तमान स्थिति';

  @override
  String get supabaseTitle => 'Supabase';

  @override
  String get supabaseProjectConnection => 'प्रोजेक्ट कनेक्शन';

  @override
  String get supabaseSdkConnected => 'SDK कनेक्टेड';

  @override
  String get supabaseNotInitialized => 'प्रारंभ नहीं';

  @override
  String get supabaseKeysProvided => 'कुंजी मिली';

  @override
  String get supabaseKeysMissing => 'कुंजी गायब';

  @override
  String get supabaseRealtimeCrud => 'Realtime CRUD सक्रिय';

  @override
  String get supabaseAuthSection => 'प्रमाणीकरण';

  @override
  String supabaseSignedInAs(String email) {
    return '$email के रूप में साइन इन';
  }

  @override
  String get supabaseSignInHint =>
      'Realtime CRUD के लिए Supabase से साइन इन करें।';

  @override
  String get supabaseKeysHint =>
      'publishable/anon कुंजी जोड़ें और ऐप पुनः प्रारंभ करें।';

  @override
  String get supabaseOpenLogin => 'लॉगिन खोलें (Supabase)';

  @override
  String get supabaseCreateAccount => 'खाता बनाएँ (Supabase)';

  @override
  String get supabaseUserTable => 'उपयोगकर्ता (profiles तालिका)';

  @override
  String get supabaseUserId => 'User ID';

  @override
  String get supabaseEmail => 'ईमेल';

  @override
  String get supabaseFullName => 'पूरा नाम';

  @override
  String get supabaseProfileCreated => 'प्रोफ़ाइल बनी';

  @override
  String get supabaseRealtimeTasks => 'Realtime tasks';

  @override
  String get authDemoTitle => 'प्रमाणीकरण';

  @override
  String get apiHttpDemoTitle => 'HTTP verbs (DummyJSON Users)';

  @override
  String get firebasePanelTitle => 'Firebase workspace';

  @override
  String get fcmToken => 'FCM token';

  @override
  String get firestoreWelcome => 'Firestore कनेक्टेड।';

  @override
  String get labelEmail => 'ईमेल';

  @override
  String get labelPhone => 'फ़ोन';

  @override
  String get labelNotes => 'नोट्स';

  @override
  String get showcaseButtons => 'बटन';

  @override
  String get showcaseButtonsSub =>
      'Primary, secondary, outlined, text, icon, loading, disabled';

  @override
  String get showcaseInputs => 'इनपुट';

  @override
  String get showcaseInputsSub =>
      'फ़ील्ड, picker, dropdown, checkbox, radio, switch';

  @override
  String get showcaseNavigation => 'नेविगेशन';

  @override
  String get showcaseNavigationSub => 'App bar, tabs, drawer, bottom bar';

  @override
  String get showcaseDisplay => 'डिस्प्ले';

  @override
  String get showcaseDisplaySub => 'कार्ड, badge, progress, rating, avatar';

  @override
  String get showcaseFeedback => 'फ़ीडबैक';

  @override
  String get showcaseFeedbackSub =>
      'Dialog, sheet, snackbar, shimmer, empty & error';

  @override
  String get showcaseMedia => 'मीडिया';

  @override
  String get showcaseMediaSub => 'Image picker, gallery, documents, video';

  @override
  String get showcaseTokens => 'Design tokens';

  @override
  String get showcaseTokensSub => 'Brand colors, radius, spacing';

  @override
  String get online => 'ऑनलाइन';

  @override
  String get offline => 'ऑफ़लाइन';

  @override
  String get avatarUploadSignIn => 'अवतार अपलोड के लिए साइन इन करें।';

  @override
  String get avatarUploadFirebaseOff => 'इस बिल्ड में Firebase बंद है।';

  @override
  String get avatarUploadSuccess => 'प्रोफ़ाइल फ़ोटो अपडेट हुई।';

  @override
  String avatarUploadFailed(String error) {
    return 'अपलोड विफल: $error';
  }

  @override
  String get labelUsername => 'उपयोगकर्ता नाम';

  @override
  String get hintUsernameApi => 'emilys';

  @override
  String get hintEmailWork => 'you@company.com';

  @override
  String get passwordHintEnter => 'अपना पासवर्ड दर्ज करें';

  @override
  String get passwordHintMin => 'कम से कम 8 अक्षर';

  @override
  String get hintFullName => 'Jane Developer';

  @override
  String get hintPhoneIndia => '+91 98765 43210';

  @override
  String get termsAgreement =>
      'मैं सेवा की शर्तें और गोपनीयता नीति से सहमत हूँ।';

  @override
  String get loginSupabaseRegNote =>
      'खाता बनाने के लिए Supabase पंजीकरण स्क्रीन का उपयोग करें।';

  @override
  String get profileProjects => 'प्रोजेक्ट';

  @override
  String get profileTasks => 'कार्य';

  @override
  String get profileAlerts => 'अलर्ट';

  @override
  String get accountSettings => 'खाता सेटिंग';

  @override
  String get securityTitle => 'सुरक्षा';

  @override
  String get securitySubtitle => 'पासवर्ड, 2FA, सत्र';

  @override
  String get appearanceTitle => 'दिखावट';

  @override
  String get appearanceSubtitle => 'थीम सिस्टम सेटिंग का पालन करती है';

  @override
  String get editProfileSubtitle => 'ऑथ मॉड्यूल के बाद उपलब्ध';

  @override
  String get profileReadyTitle => 'प्रोफ़ाइल तैयार';

  @override
  String get profileReadyMessage =>
      'Firebase Authentication कनेक्ट है। जैसे-जैसे फ़ीचर जुड़ेंगे, और प्रोफ़ाइल फ़ील्ड दिखेंगी।';

  @override
  String get verifyEmailProfileTitle => 'अपना ईमेल सत्यापित करें';

  @override
  String get verifyEmailProfileMessage =>
      'Firebase सत्यापन लिंक के लिए अपना इनबॉक्स देखें, या पंजीकरण से ईमेल सत्यापन खोलें।';

  @override
  String get supabaseUrlMissingConfig =>
      'dart_defines/supabase.local.json में SUPABASE_URL सेट करें';

  @override
  String get supabaseSetupSteps =>
      '1) SQL चलाएँ: supabase/migrations/001_ada_tasks.sql\n2) Auth → Email provider (confirm email वैकल्पिक)\n3) नीचे Supabase से साइन इन करें, फिर Realtime tasks उपयोग करें';

  @override
  String get supabaseSignInCrudHint =>
      'Realtime CRUD के लिए Supabase से साइन इन करें (RLS auth.uid() उपयोग करता है)।';

  @override
  String get supabaseCrudUnavailable =>
      'सत्र Supabase है पर CRUD उपलब्ध नहीं। ada_tasks के SQL migration और Realtime publication जाँचें।';

  @override
  String get urlLabel => 'URL';

  @override
  String get backToSignIn => 'साइन इन पर वापस जाएँ';

  @override
  String get passwordUpdatedSuccess => 'पासवर्ड सफलतापूर्वक अपडेट हुआ।';

  @override
  String get otpCodeRequired => 'कृपया 6 अंकों का कोड दर्ज करें।';

  @override
  String get otpVerifiedSuccess => 'फ़ोन/ईमेल सत्यापित। अब साइन इन करें।';

  @override
  String verifyEmailSubtitle(String email) {
    return 'हमने $email पर पुष्टि लिंक भेजा है।';
  }

  @override
  String otpSentTo(String email) {
    return 'हमने $email पर 6 अंकों का कोड भेजा है';
  }

  @override
  String get setNewPasswordTitle => 'नया पासवर्ड सेट करें';

  @override
  String get passwordResetEmailSent =>
      'पासवर्ड रीसेट ईमेल भेजा गया। अपना इनबॉक्स देखें।';

  @override
  String get forgotPasswordInstructions =>
      'अपना ईमेल दर्ज करें; Firebase पासवर्ड रीसेट लिंक भेजेगा।';

  @override
  String get verifyEmailCheckInbox => 'अपना ईमेल देखें';

  @override
  String get verifyEmailInstructions =>
      'Firebase सत्यापन ईमेल में लिंक खोलें, फिर नीचे \"मैंने सत्यापित किया\" दबाएँ।';

  @override
  String get emailVerifiedButton => 'मैंने अपना ईमेल सत्यापित किया';

  @override
  String get resendEmail => 'ईमेल फिर भेजें';

  @override
  String get verificationEmailSentAgain => 'सत्यापन ईमेल फिर भेजा गया।';

  @override
  String get emailVerifiedSuccess => 'ईमेल सफलतापूर्वक सत्यापित।';

  @override
  String get emailNotVerifiedYet =>
      'ईमेल अभी सत्यापित नहीं। इनबॉक्स में लिंक खोलें।';

  @override
  String get confirmNewPassword => 'नया पासवर्ड पुष्टि करें';

  @override
  String resetPasswordSubtitleEmail(String email) {
    return '$email के लिए नया पासवर्ड बनाएँ';
  }

  @override
  String get resetPasswordSubtitleGeneric =>
      'अपने खाते के लिए मज़बूत पासवर्ड चुनें।';

  @override
  String get otpDemoHint => 'डेमो: जारी रखने के लिए कोई भी 6 अंक उपयोग करें।';

  @override
  String resendCodeIn(int seconds) {
    return '$seconds सेकंड में कोड फिर भेजें';
  }
}
