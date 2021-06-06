import 'package:covid_19_tracker/constant.dart';
import 'package:covid_19_tracker/service/api_service.dart';
import 'package:covid_19_tracker/service/dataModel.dart';
import 'package:covid_19_tracker/widgets/counter.dart';
import 'package:covid_19_tracker/widgets/my_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19-Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: TextTheme(
          body1:TextStyle(color: kBodyTextColor),
        )
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  String country = 'India';
  List<String>countries = [];
  dataModel model;
  var service = ApiService();

  @override
  void initState() {
    super.initState();
    service.isLoading = true;
    service.getCountries();
    service.getCountries().then((result){
      setState(() {
        this.countries = result;
      });
    });
    service.getCountry('India').then((value) {
      setState(() {
        this.model = value;
        service.isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body:SingleChildScrollView(
          child: Column(
            children: [
              MyHeader(
                image: "assets/icons/Drcorona.svg",
                textTop: "All you need",
                textBottom: "is stay at home",
                homepage: true,
              ),
              Container(
                margin:EdgeInsets.symmetric(horizontal: 20),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Color(0xFFE5E5E5)),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                            value: country,
                            items: countries
                                .map<DropdownMenuItem<String>>((String value){
                                  setState(() {

                                  });
                              return DropdownMenuItem(
                                  value:value,
                                  child: Text(value));
                            }).toList(),
                            onChanged: (value)async{
                              setState(() {
                                service.isLoading = true;
                                country = value;
                              });

                              var result = await service.getCountry(value);
                              setState(()  {

                                this.model = result;
                                service.isLoading=false;
                              });
                            },
                          ),)
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Case Update\n',
                                    style: kTitleTextstyle
                                ),
                                TextSpan(
                                    text: model==null?'':'Newest update ${model.lastUpdatedMonth} ${model.lastUpdatedDay}',
                                    style: TextStyle(color: kTextLightColor)
                                ),
                              ],
                            )
                        ),
                        Spacer(),
                        Text(
                          "See details",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600),)
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(offset: Offset(0, 4),
                              blurRadius: 30,
                              color: kShadowColor,
                            ),
                          ]
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          service.isLoading==true?Container():Counter(
                            color: kInfectedColor,
                            number: model.infected,
                            title: "Infected",),
                          service.isLoading==true?CircularProgressIndicator():Counter(
                            color: kDeathColor,
                            number: model.dead,
                            title: "Deaths",),
                          service.isLoading==true?Container():Counter(
                            color: kRecovercolor,
                            number: model.recovered,
                            title: "Recovered",),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Spread of Virus",
                          style: kTitleTextstyle,
                        ),
                        Text(
                            "See details",
                            style:TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600
                            )
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top:20),
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0,10),
                              blurRadius: 30,
                              color: kShadowColor,
                            )
                          ]
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset("assets/images/globalmap.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

}






