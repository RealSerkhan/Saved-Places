import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:saved_places/place.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saved Places',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SavedPlaces(),
    );
  }
}

class SavedPlaces extends StatefulWidget {
  @override
  _SavedPlacesState createState() => _SavedPlacesState();
}

class _SavedPlacesState extends State<SavedPlaces> {
  Map<int, Place> data = {
    1: Place('Nasimi,Samad Vurgun 108c', PlaceType.SecondHome),
    2: Place('28 May', PlaceType.Work),
    3: Place('Narimanov,Restaurant Kababchi', PlaceType.Restaurant),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        toolbarHeight: 30,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Saved Places',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const Text(
                  'Save your favorite destionations.',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.custom(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              childrenDelegate: SliverChildListDelegate([
                listItemWidget('Zarifa ALiyeva str.89', PlaceType.Home),
                listItemWidget('Naftchilar, ave,101', PlaceType.Work)
              ])),
          SizedBox(
            height: 10,
          ),
          ListView.custom(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              childrenDelegate: SliverChildListDelegate(data.entries
                  .map((e) => Slidable.builder(
                      actionPane: SlidableDrawerActionPane(),
                      key: GlobalKey(),
                      dismissal: SlidableDismissal(
                        child: SlidableDrawerDismissal(),
                        dragDismissible: false,
                        closeOnCanceled: true,
                        onDismissed: (action) {},
                      ),
                      secondaryActionDelegate: SlideActionBuilderDelegate(
                        actionCount: 1,
                        builder: (contextSlide, index, animation, step) {
                          var state = Slidable.of(contextSlide);
                          return ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                              ),
                              child: IconSlideAction(
                                color: Colors.red.withOpacity(0.15),
                                iconWidget: Text('Delete'),
                                onTap: () {
                                  state!.dismiss(
                                      actionType: SlideActionType.secondary);
                                  data.remove(e.key);

                                  // chatState.notifyListeners();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      child: listItemWidget(e.value.location, e.value.type)))
                  .toList())),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Add Saved Place',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'get to your favorite destionation faster',
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        )
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget listItemWidget(String subtitle, PlaceType type) {
    Widget listItemIcon;
    late String title;
    switch (type) {
      case PlaceType.Gym:
        listItemIcon = Icon(Icons.holiday_village);
        title = 'Gym';
        break;
      case PlaceType.SecondHome:
        listItemIcon = Icon(
          Icons.home,
          color: Colors.blueAccent,
        );
        title = 'Second Home';
        break;
      case PlaceType.Work:
        listItemIcon = Icon(
          Icons.work,
          color: Colors.blueAccent,
        );
        title = 'Work';
        break;
      case PlaceType.Home:
        listItemIcon = Icon(
          Icons.home,
          color: Colors.blueAccent,
        );
        title = 'Work';
        break;
      case PlaceType.Restaurant:
        listItemIcon = Icon(Icons.restaurant);
        title = 'Restaurant';
        break;
      default:
        listItemIcon = SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            listItemIcon,
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                )
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              size: 20,
            )
          ],
        ),
      ),
    );
  }

  // Widget getListItemIcon(PlaceType type) {
  //   switch (type) {
  //     case PlaceType.Gym:
  //       return Icon(Icons.holiday_village);
  //     case PlaceType.SecondHome:
  //       return Icon(Icons.home);
  //     case PlaceType.Work:
  //       return Icon(Icons.work);
  //     default:
  //       return Icon(Icons.accessible);
  //   }
  // }
}

enum PlaceType { Work, SecondHome, Gym, Home, Restaurant }
