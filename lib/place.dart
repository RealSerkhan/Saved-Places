import 'package:flutter/material.dart';
import 'package:saved_places/main.dart';

class Place {
  late PlaceType type;
  late String location;
  Place(this.location, this.type);
}
