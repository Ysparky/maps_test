part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () async {
            print(context.bloc<SearchBloc>().state.searchHistory.length);
            final result = await showSearch(
              context: context,
              delegate: SearchDestination(
                context.bloc<UserLocationBloc>().state.location,
                context.bloc<SearchBloc>().state.searchHistory,
              ),
            );
            searchResults(context, result);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 13.0,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ),
              ],
            ),
            child: Text('Where do you want to go?'),
          ),
        ),
      ),
    );
  }

  Future searchResults(BuildContext context, SearchResult searchResult) async {
    if (searchResult.isCanceled) return;

    final trafficService = new TrafficService();
    final mapBloc = context.bloc<MapBloc>();
    final origin = context.bloc<UserLocationBloc>().state.location;
    final destination = searchResult.position;

    final drivingResponse = await trafficService
        .getRoutePointsByOriginAndDestination(origin, destination);

    final geometry = drivingResponse.routes[0].geometry;
    final distance = drivingResponse.routes[0].distance;
    final duration = drivingResponse.routes[0].duration;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);

    final routePoints = points.decodedCoords
        .map((point) => LatLng(point[0], point[1]))
        .toList();

    context.bloc<SearchBloc>().add(OnAddSearchHistory(searchResult));
    mapBloc.add(OnDrawDestinationRoute(routePoints, distance, duration));
    context.bloc<MapBloc>().moveCamera(destination);
  }
}
