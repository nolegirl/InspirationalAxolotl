

class Axolotl {
  final String imageUrl;
  final String facts;

  Axolotl({
    required this.imageUrl,
    required this.facts,
  });

  factory Axolotl.fromJson(Map<String, dynamic> json) {
    return Axolotl(
      imageUrl: json['url'],
      facts: json['facts'],
    );
  }
}

/* sample readout
 "url": "https://i.redd.it/ifcdx5d1zfu61.jpg",
    "facts": "We absolutely love begging our owners for food when we see them.",
    "pics_repo": "https://github.com/AxolotlAPI/data",
    "api_repo": "https://github.com/AxolotlAPI/axolotl.py-api"
 */