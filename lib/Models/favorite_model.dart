
class Favorite{
  String name;
  String city;
  String state;
  String description;
  String urlImage;

  Favorite(this.name, this.city, this.state, this.description, this.urlImage);

  Favorite.fromJson(Map<String, dynamic> json):
        name = json['name'],
        city = json['city'],
        state = json['state'],
        description = json['description'],
        urlImage = json['image'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'city': city,
    'state': state,
    'description': description,
    'image': urlImage
  };

}