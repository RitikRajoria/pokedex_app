class PokemonInfoResponse {
  final int id;
  final String name;
  final String imageurl;
  final List<String> types;
  final int height;
  final String weight;

  PokemonInfoResponse(
      {required this.id,
      required this.name,
      required this.imageurl,
      required this.types,
      required this.height,
      required this.weight});

  factory PokemonInfoResponse.fromJson(Map<String, dynamic> json) {
    final types = (json['types'] as List)
        .map((e) => e['type']['name'] as String)
        .toList();
    return PokemonInfoResponse(
        id: json['id'],
        name: json['name'],
        imageurl: json['sprites']['front-default'],
        types: types,
        height: json['height'],
        weight: json['weight']);
  }
}
