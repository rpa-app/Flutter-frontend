import 'package:url_launcher/url_launcher.dart';

class LaunchEmail {
  launchEmail() async {
    String email = Uri.encodeComponent("rpaventures3@gmail.com");
    String subject = Uri.encodeComponent("Bharat Political Poster App ");
    String body = Uri.encodeComponent("Mention your query : ");
    Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
    if (await launchUrl(mail)) {
      //email app opened
    } else {
      //email app is not opened
    }
  }
}
