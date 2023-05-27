import 'package:ASA/src/screens/ConsumerAccountScreen/SubScreen/ConsumerForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../assets/constants/image_strings.dart';


class ConsumerService extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ConsumerService> {
  
 List<String> icons = [
    'assets/images/water.png',
    'assets/images/paint-roller.png',
    'assets/images/metalworking.png',
    'assets/images/lightning.png',
    'assets/images/hammering.png',
    'assets/images/clean-dishes.png',
    'assets/images/air-conditioner.png',
    'assets/images/grass-cutter.png',
    'assets/images/vacuum.png',
  ];

  List<String> iconTitles = [
    'Plumbing',
    'Paint',
    'Metal Work',
    'Electrical Work',
    'Wood Work',
    'Dish Cleaning',
    'AC Fix',
    'Grass Cutting',
    'Carpet Clean',
  ];
   @override
  Widget build(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  return Scaffold(
    body: Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    accountbackground,
                    fit: BoxFit.cover,
                  ),
                ), 
                Padding(
                  padding: EdgeInsets.only(top: mediaQuery.size.height * 0.08),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Services',
                      style: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center, // Align the text at the center
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: mediaQuery.size.height * 0.22),
                    child: Stack(
              children: List.generate(icons.length, (index) {
                return Positioned(
                  left: (index % 3) * 127.0, // Adjust the positioning based on your preference
                  top: (index ~/ 3) * 200.0, // Adjust the positioning based on your preference
                  child: GestureDetector(
                    onTap: () {
                      // Handle icon onPress action
                      print('Icon ${index + 1} pressed');
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ConsumerForm(data:index + 1 ), // Pass the desired data to the ConsumerForm screen
    ),
  );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 80.0, // Adjust the width of the container as per your preference
                          height: 80.0, // Adjust the height of the container as per your preference
                          padding: EdgeInsets.all(8.0), // Adjust the padding within the container as per your preference
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(icons[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0), // Adjust the vertical spacing between icon and text
                        Text(
                          iconTitles[index],
                          style: TextStyle(fontSize: 16.0), // Adjust the text style as per your preference
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
                  ),
                ),  
         
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

}

