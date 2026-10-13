/// Agency contact details — CLAUDE.md section 1.
abstract final class AppContact {
  static const String phoneDisplay = '240-423-3099';
  static const String phoneDial = '2404233099';

  /// Digits spaced so screen readers read them one by one.
  static const String phoneSpoken = '2 4 0, 4 2 3, 3 0 9 9';
}

/// Shared user-facing copy. Feature-specific copy lives with its feature.
abstract final class AppStrings {
  static const String appName = 'Spirit of Hope';

  static const String callUs = 'Call us';
  static const String callUsWithNumber = 'Call us: ${AppContact.phoneDisplay}';
  static const String callUsSemantic =
      'Call Spirit of Hope at ${AppContact.phoneSpoken}';
  static const String callFailed =
      "Couldn't open your phone app. Please call ${AppContact.phoneDisplay}.";

  static const String loading = 'Loading…';
  static const String loadingSemanticSuffix = ', loading';

  static const String errorTitle = 'Something went wrong';
  static const String tryAgain = 'Try again';
  static const String errorCallFallback =
      'Prefer to talk to someone? We are happy to help by phone.';

  static const String debugStyleguideLink = 'Open styleguide (debug)';
}
