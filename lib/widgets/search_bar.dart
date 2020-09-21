part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
              context: context,
              delegate: SearchDestination(
                context.bloc<UserLocationBloc>().state.location,
              ),
            );
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

  void searchResults(SearchResult searchResult) {
    if (searchResult.isCanceled) return;
  }
}
