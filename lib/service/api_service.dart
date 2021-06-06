import 'dart:convert';

import 'package:covid_19_tracker/service/dataModel.dart';
import 'package:http/http.dart' as http;

class ApiService{
  bool isLoading;
  ApiService(){
    this.isLoading = false;
  }

  Future<List<String>> getCountries() async{
      final response = await http.get(Uri.parse('https://www.trackcorona.live/api/countries'));
      Map data = jsonDecode(response.body);
      List<String> countries = [];
      for (var country in data['data']){
        countries.add(country['location']);
      }
      return countries;
  }

  Future<dataModel> getCountry(String country) async{
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    final response = await http.get(Uri.parse('https://www.trackcorona.live/api/countries'));
    Map data = jsonDecode(response.body);
    dataModel model;
    for (var c in data['data']){
      if (c['location']==country){
        var parsedDate = DateTime.parse(c['updated']);
        model = dataModel(c['confirmed'], c['dead'], c['recovered'], months[parsedDate.month-1],parsedDate.day.toString());
      }
    }
    return model;
  }

}