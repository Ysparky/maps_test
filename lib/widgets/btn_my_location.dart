part of 'widgets.dart';

class BtnMyLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black87),
          onPressed: () {
            final myLocation = context.bloc<UserLocationBloc>().state.location;
            context.bloc<MapBloc>().moveCamera(myLocation);
          },
        ),
      ),
    );
  }
}
