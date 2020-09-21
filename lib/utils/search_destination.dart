import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_test/bloc/Map/map_bloc.dart';
import 'package:maps_test/models/search_response.dart';
import 'package:maps_test/models/search_result.dart';
import 'package:maps_test/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {
  final TrafficService _trafficService;
  final LatLng proximityPoint;
  final List<SearchResult> searchHistory;

  SearchDestination(this.proximityPoint, this.searchHistory)
      : this._trafficService = new TrafficService();

  @override
  String get searchFieldLabel => 'Busca aquí';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () => this.query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => this.close(context, SearchResult(isCanceled: true)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildPlaces();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (this.query.length == 0) {
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Buscar manualmente'),
            onTap: () {
              this.close(
                context,
                SearchResult(
                  isCanceled: false,
                  isManual: true,
                ),
              );
            },
          ),
          ...this
              .searchHistory
              .map((searchResult) => ListTile(
                    leading: Icon(Icons.history),
                    title: Text(searchResult.targetName),
                    subtitle: Text(searchResult.description),
                    onTap: () {
                      this.close(
                        context,
                        searchResult,
                      );
                    },
                  ))
              .toList(),
        ],
      );
    }

    return _buildPlaces();
  }

  Widget _buildPlaces() {
    return FutureBuilder(
      future:
          _trafficService.getResultsByQuery(this.query, this.proximityPoint),
      builder: (BuildContext context, AsyncSnapshot<SearchResponse> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final places = snapshot.data.features;

        if (places.length == 0) {
          return Center(
            child: Text(
                'No se han encontrado lugares relacionados con ${this.query}'),
          );
        }

        return ListView.separated(
          itemCount: places.length,
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (context, index) {
            final place = places[index];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(place.textEs),
              subtitle: Text(place.placeNameEs),
              onTap: () {
                this.close(
                  context,
                  SearchResult(
                    isCanceled: false,
                    isManual: false,
                    position: LatLng(place.center[1], place.center[0]),
                    targetName: place.textEs,
                    description: place.placeNameEs,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
