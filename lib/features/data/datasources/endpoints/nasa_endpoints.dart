class NasaEndpoints {
  static String apod(String apiKey, String date) =>
      'https://api.nasa.gov/planetary/apod?hd=true&api_key=$apiKey&date=$date';
}
