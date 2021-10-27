class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longitude}) {
    return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/$longitude,$latitude,16,0/1000x400?access_token=pk.eyJ1Ijoicm9vcGFpc2giLCJhIjoiY2t2OWU1eDF6YTI4ZDMwcWptNXR4aGhoaSJ9.GoTZXtGmHQnjMoyX59EntA';
  }
}
