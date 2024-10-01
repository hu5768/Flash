import 'package:url_launcher/url_launcher.dart';

class OpenWeb {
  Future<void> OpenInstagram(String instagramId) async {
    String instagramUrl = 'instagram://user?username=$instagramId/';
    String instagramWebUrl = 'https://www.instagram.com/$instagramId/';
    if (await canLaunchUrl(Uri.parse(instagramUrl))) {
      await launchUrl(Uri.parse(instagramUrl));
    } else if (await canLaunchUrl(Uri.parse(instagramWebUrl))) {
      await launchUrl(Uri.parse(instagramWebUrl));
    } else {
      throw 'Could not launch $instagramUrl';
    }
  }
}
