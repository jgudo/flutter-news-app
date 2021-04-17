import 'dart:convert';

NewsSource sourcesFromJson(String str) => NewsSource.fromJson(json.decode(str));

String sourcesToJson(NewsSource data) => json.encode(data.toJson());

class NewsSource {
  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  NewsSource({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      url: json["url"],
      category: json["category"],
      language: json["language"],
      country: json["country"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "url": url,
        "category": category,
        "language": language,
        "country": country,
      };
}
