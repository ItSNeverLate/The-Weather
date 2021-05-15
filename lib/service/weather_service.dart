import 'package:http/http.dart' as http;

const WEATHER_SERVICE_BASE_URL = 'api.openweathermap.org';
const WEATHER_SERVICE_API_KEY = '894704b57753bddd1368af1ec834e0d0';

class WeatherService {
  Future<http.Response> getWeatherDataByLocation(
    double lat,
    double lon,
  ) async {
    var queryParameters = {
      'lat': lat.toString(),
      'lon': lon.toString(),
      'appid': WEATHER_SERVICE_API_KEY,
      'units': 'metric'
    };
    var uri = Uri.https(
      WEATHER_SERVICE_BASE_URL,
      '/data/2.5/weather',
      queryParameters,
    );
    http.Response response = await http.get(uri);
    return response;
  }

  Future<http.Response> getWeatherDataByCity(
    String city,
  ) async {
    var queryParameters = {
      'q': city,
      'appid': WEATHER_SERVICE_API_KEY,
      'units': 'metric'
    };
    var uri = Uri.https(
      WEATHER_SERVICE_BASE_URL,
      '/data/2.5/weather',
      queryParameters,
    );
    http.Response response = await http.get(uri);
    return response;
  }
}
