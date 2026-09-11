import 'package:flutter/material.dart';
import '../models/player.dart';
import 'game_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int playerCount = 1;
  bool hasSavedGame = false;

  List<TextEditingController> playerControllers = [
    TextEditingController(),
  ];

  @override
  void initState() {
    super.initState();

    loadPlayerNames();
  }

  @override
  void dispose() {
    for (final controller in playerControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> loadPlayerNames() async {
    final prefs = await SharedPreferences.getInstance();

    final playersJson = prefs.getString("players");
    if (playersJson == null) {
      return;
    }

    final decoded = jsonDecode(playersJson);

    final players = (decoded as List)
      .map((json) => Player.fromJson(json))
      .toList();

    setState(() {
      hasSavedGame = true;
      playerCount = players.length;

      playerControllers.clear();

      for (final player in players) {
        playerControllers.add(
          TextEditingController(
            text: player.name,
          ),
        );
      }

    });
  }

  Future<void> clearSavedGame() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("players");
    await prefs.remove("farthestPlateWinner");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waypoint"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Players",
                style: TextStyle(fontSize: 24),
              ),

              const SizedBox(height: 20),

              // Player Count
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (playerCount > 1) {
                          playerCount--;

                          playerControllers.last.dispose();
                          playerControllers.removeLast();
                        }
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),

                  Text(
                    "$playerCount",
                    style: const TextStyle(fontSize: 24),
                  ),

                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (playerCount < 8) {
                          playerCount++;

                          playerControllers.add(
                            TextEditingController(),
                          );
                        }
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Player Names
              if (playerControllers.length >= playerCount)
              ...List.generate(
                playerCount,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: playerControllers[index],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Player ${index + 1}",
                    ),
                  ),
                ),
              ),

              // Start Button
              ElevatedButton(
                onPressed: () async {
                  await clearSavedGame();

                  if (!context.mounted) return;

                  List<Player> players = [];

                  for (var controller in playerControllers) {
                    players.add(
                      Player(
                        name: controller.text,
                      ),
                    );
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        players: players,
                      ),
                    ),
                  ).then((_) {
                    loadPlayerNames();
                  });
                },
                child: const Text("New Game"),
              ),

              // Continue Button
              if (hasSavedGame)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    List<Player> players = [];

                    for (var controller in playerControllers) {
                      players.add(
                        Player(
                          name: controller.text,
                        ),
                      );
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GameScreen(
                          players: players,
                        ),
                      ),
                    ).then((_) {
                      loadPlayerNames();
                    });
                  },
                  child: const Text("Continue Game"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}