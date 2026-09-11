class Player {
  String name;

  int zitchDogScore;
  int slugBugScore;
  int roadToiletScore;
  int nameThatTuneScore;

  int get totalScore {
    return zitchDogScore +
        (slugBugScore * 2) +
        (roadToiletScore * 10) +
        nameThatTuneScore;
  }

  Player({
    required this.name,
    this.zitchDogScore = 0,
    this.slugBugScore = 0,
    this.roadToiletScore = 0,
    this.nameThatTuneScore = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'zitchDogScore': zitchDogScore,
      'slugBugScore': slugBugScore,
      'roadToiletScore': roadToiletScore,
      'nameThatTuneScore': nameThatTuneScore,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      zitchDogScore: json['zitchDogScore'],
      slugBugScore: json['slugBugScore'],
      roadToiletScore: json['roadToiletScore'],
      nameThatTuneScore: json['nameThatTuneScore'],
    );
  }
}