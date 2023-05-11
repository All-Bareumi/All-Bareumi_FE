import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  final String url;
  final String url2;
  Network(this.url, this.url2);

  Future<dynamic> getJsonData() async{
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200){
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }

  Future<dynamic> getAirData() async{
    http.Response response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200){
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }
  }
  // 이후 데이터 필요한 곳에서 아래 코드와 같이 사용할 수 있음.
  // Network network = Network(
  //     'https://api.openweathermap.org/data/2.5/weather'
  //         '?lat=$latitude3&lon=$longitude3&appid=$apiKey&units=metric',
  //     'https://api.openweathermap.org/data/2.5/air_pollution'
  //         '?lat=$latitude3&lon=$longitude3&appid=$apiKey');
  // var weatherData = await network.getJsonData();
  // print(weatherData);
  //
  // var airData = await network.getAirData();
  // print(airData);

}