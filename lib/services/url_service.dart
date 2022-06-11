import 'package:url_launcher/url_launcher.dart';

class OpenLinkService {
  /// Opens the given [url]
  ///
  /// Throws error if the link can't be opened
  Future openLink(String url) async => await launch(url);
}

/// Custom Exception for handling link open exceptions
class OpenLinkException implements Exception {
  final String message;
  final String? devDetails;

  OpenLinkException({
    required this.message,
    this.devDetails,
  });

  @override
  String toString() {
    return 'OpenLinkException: $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}
