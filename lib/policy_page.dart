import 'package:flutter/material.dart';

class PolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Thesaurus App',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Effective Date: June 22, 2024',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20.0),
            Text(
              'Welcome to Thesaurus! This Privacy Policy describes how ("we", "us", "our") collects, uses, and shares information about you when you use our Thesaurus mobile application (the "App").',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Information We Collect',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'Personal Information:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'We do not collect any personally identifiable information (such as your name, email address, phone number) through the App.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Usage Data:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'We may collect information about how you use the App, such as the features you access and interactions with the App.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Device Information:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'We may collect device-specific information, such as your device model, operating system version, unique device identifiers, and mobile network information.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'How We Use Your Information',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We use the information we collect for the following purposes:',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- To Improve and Personalize Your Experience: Understanding how users interact with the App helps us improve its functionality and personalize your experience.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Analytics: We may use analytics tools to analyze usage trends and optimize the performance of the App.',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              '- Security: We take measures to protect the App and its users from unauthorized access and abuse.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Information Sharing',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We do not share, sell, or disclose your information to third parties except as described in this Privacy Policy or with your consent.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Data Retention',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We retain the information we collect for as long as necessary to fulfill the purposes outlined in this Privacy Policy unless a longer retention period is required or permitted by law.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Security',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              'We implement reasonable security measures to protect the information we collect. However, no method of transmission over the internet or electronic storage is completely secure.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              "Children’s Privacy",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              "The App is not directed to children under the age of 13. We do not knowingly collect personal information from children under 13. If we learn that we have collected personal information from a child under 13, we will promptly delete that information.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              "Changes to This Privacy Policy",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              "We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Text(
              "Contact Us",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              "If you have any questions or concerns about this Privacy Policy, please contact us.",
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
