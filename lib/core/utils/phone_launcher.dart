import 'package:url_launcher/url_launcher.dart';

import '../constants/app_strings.dart';

/// Opens the dialler with the agency number. Returns false if no app could
/// handle the call (e.g. a tablet without telephony), so callers can show a
/// fallback rather than failing silently.
Future<bool> launchAgencyCall() async {
  final uri = Uri(scheme: 'tel', path: AppContact.phoneDial);
  try {
    return await launchUrl(uri);
  } on Exception {
    return false;
  }
}
