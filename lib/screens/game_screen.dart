import 'package:flutter/material.dart';
import '../models/player.dart';
import '../widgets/score_counter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GameScreen extends StatefulWidget {
  final List<Player> players;

  const GameScreen({
    super.key,
    required this.players,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int farthestPlateWinner = -1;

  @override
  void initState() {
    super.initState();

    loadGame();
  }

  Future<void> loadGame() async {
    final prefs = await SharedPreferences.getInstance();

    final playersJson = prefs.getString("players");
    if (playersJson == null) return;

    final decoded = jsonDecode(playersJson);

    final loadedPlayers = (decoded as List)
          .map((json) => Player.fromJson(json))
          .toList();

    final winner = prefs.getInt("farthestPlateWinner") ?? -1;

    setState(() {
      widget.players.clear();
      widget.players.addAll(loadedPlayers);
      farthestPlateWinner = winner;
    });
  }

  Future<void> saveGame() async {
    final prefs = await SharedPreferences.getInstance();

    String playersJson = jsonEncode(
      widget.players.map((p) => p.toJson()).toList(),
    );

    await prefs.setString("players", playersJson);

    await prefs.setInt(
      "farthestPlateWinner",
      farthestPlateWinner,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waypoint"),
      ),
      body: ListView(
      children: widget.players.asMap().entries.map((entry) {
        final index = entry.key;
        final player = entry.value;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Total: ${player.totalScore + (farthestPlateWinner == index ? 5 : 0)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // Zitch Dog
                ScoreCounter(
                  label: "Zitch Dog",
                  value: player.zitchDogScore,

                  onIncrement: () {
                    setState(() {
                        player.zitchDogScore++;
                    });

                    saveGame();
                  },

                  onDecrement: () {
                    setState(() {
                      if (player.zitchDogScore > 0) {
                        player.zitchDogScore--;
                      }
                    });

                    saveGame();
                  },
                ),

                // Slug Bug
                ScoreCounter(
                  label: "Slug Bug",
                  value: player.slugBugScore,

                  onIncrement: () {
                    setState(() {
                      player.slugBugScore++;
                    });

                    saveGame();
                  },

                  onDecrement: () {
                    setState(() {
                      if (player.slugBugScore > 0) {
                        player.slugBugScore--;
                      }
                    });

                    saveGame();
                  },
                ),

                // Road Toilet
                ScoreCounter(
                  label: "Road Toilet",
                  value: player.roadToiletScore,

                  onIncrement: () {
                    setState(() {
                      player.roadToiletScore++;
                    });

                    saveGame();
                  },

                  onDecrement: () {
                    setState(() {
                      if (player.roadToiletScore > 0) {
                        player.roadToiletScore--;
                      }
                    });

                    saveGame();
                  },
                ),

                // Name that Tune
                ScoreCounter(
                  label: "Name that Tune",
                  value: player.nameThatTuneScore,

                  onIncrement: () {
                    setState(() {
                      player.nameThatTuneScore++;
                    });

                    saveGame();
                  },

                  onDecrement: () {
                    setState(() {
                      if (player.nameThatTuneScore > 0) {
                        player.nameThatTuneScore--;
                      }
                    });

                    saveGame();
                  },
                ),

                // License Plate Game
                Row(
                  children: [
                    Checkbox(
                      value: farthestPlateWinner == index,
                      onChanged: (value) {
                        setState(() {
                          farthestPlateWinner = index;
                        });

                        saveGame();
                      },
                    ),

                    const Text("Farthest License Plate"),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    ),
    );
  }
}