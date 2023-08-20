class Event {
  String name;
  String image;
  double waist;
  double shoulder;
  double height;
  Map category;
  String location;
  String cost;
  int available;
  String about;
  List<String> tone;

  Event({
    required this.name,
    required this.image,
    required this.category,
    required this.location,
    required this.cost,
    required this.available,
    required this.about,
    required this.waist,
    required this.shoulder,
    required this.height,
    required this.tone,
  });
}
