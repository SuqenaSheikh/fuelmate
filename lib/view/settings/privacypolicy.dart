import 'package:flutter/material.dart';
import 'package:fuelmate/view/settings/widgets/general_Aboutus.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return const generalAboutScreen(
      appBarText:'Privacy Policy',
      heading: 'Privacy Policy for Fuel Mate',
      description: 'Lorem ipsum dolor sit amet consectetur. Sit'
          'pulvinar mauris mauris eu nibh semper nisl '
          'pretium laoreet. Sed non faucibus ac lectus '
          'eu arcu. Nulla sit congue facilisis vestibulum '
          'egestas nisl feugiat pharetra. Odio sit tortor'
          ' morbi at orci ipsum dapibus interdum. Lorem felis'
          ' est aliquet arcu nullam pellentesque. Et habitasse '
          'ac arcu et nunc euismod rhoncus facilisis sollicitudin.',
    );
  }
}
