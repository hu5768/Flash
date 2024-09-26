import 'package:url_launcher/url_launcher.dart';

class OpenWeb {
  Future<void> OpenInstagram(String instagramId) async {
    String instagramUrl = 'https://www.instagram.com/$instagramId/';
    if (await canLaunchUrl(Uri.parse(instagramUrl))) {
      await launchUrl(Uri.parse(instagramUrl));
    } else {
      throw 'Could not launch $instagramUrl';
    }
  }
}
