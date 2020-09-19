part of 'widgets.dart';

class BtnFollowLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(
                  state.followLocation
                      ? Icons.directions_run
                      : Icons.accessibility_new,
                  color: Colors.black87),
              onPressed: () {
                context.bloc<MapBloc>().add(OnFollowLocation());
              },
            ),
          ),
        );
      },
    );
  }
}
