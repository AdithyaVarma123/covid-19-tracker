import 'package:covid_19_tracker/constant.dart';
import 'package:covid_19_tracker/widgets/my_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyHeader(
              image: "assets/icons/coronadr.svg",
              textTop: "Get to know", 
              textBottom: "About Covid-19",
              homepage: false,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Symptoms',
                    style: kTitleTextstyle,
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SymptomsCard(
                        image: "assets/images/headache.png",
                        title: "Headache",
                        isActive: true,
                      ),
                      SymptomsCard(
                        image: "assets/images/cough.png",
                        title: "Cough",
                      ),
                      SymptomsCard(
                        image: "assets/images/fever.png",
                        title: "Fever",
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Prevention",
                    style: kTitleTextstyle,
                  ),
                  SizedBox(height: 20,),
                  PreventCard(
                    image: "assets/images/wear_mask.png",
                    title: "Wear face mask",
                    text: "since the start of coronavirus outbreak some places have fully embraced wearing facemasks",
                  ),
                  PreventCard(
                    image: "assets/images/wash_hands.png",
                    title: "Wash your hands",
                    text: "since the start of coronavirus outbreak some places have fully embraced wearing facemasks",
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key, this.image, this.title, this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: SizedBox(
        height: 105,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,8),
                    blurRadius: 24,
                    color: kShadowColor
                  )
                ]
              ),
            ),
            Image.asset(image),
            Positioned(
              left: 130,
                child: Container(
                  height: 136,
                    width: MediaQuery.of(context).size.width-170,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text(
                            title,
                          style: kTitleTextstyle.copyWith(
                            fontSize: 16
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                      ],
                    ),
                ))
          ],
        ),
      ),
    );
  }
}

class SymptomsCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomsCard({
    Key key, this.image, this.title, this.isActive=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow:  [
          isActive?
          BoxShadow(
            offset: Offset(0,10),
            blurRadius: 20,
            color: kActiveShadowColor,
          ):
          BoxShadow(
            offset: Offset(0,3),
            blurRadius: 6,
            color: kShadowColor,
          )

        ]
      ),
      child: Column(
        children: [
           Image.asset(
               image,
             height: 90,
           ),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),)
        ],
      ),
    );
  }
}
