part of 'widgets.dart';

class BtnMyRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.remove_red_eye, color: Colors.black87),
          onPressed: () {
            context.bloc<MapBloc>().add(OnToggleTrackingRoute());
          },
        ),
      ),
    );
  }
}
