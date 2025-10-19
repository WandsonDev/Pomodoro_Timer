import 'package:flutter_soloud/flutter_soloud.dart';

class SoundService {
  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;
  SoundService._internal();

  final soloud = SoLoud.instance;
  final Map<String, AudioSource> _sounds = {};
  bool _initialized = false;


  Future<void> init() async {
    if (_initialized) return;

    await soloud.init();
    _initialized = true;

    final effects = {
      'start': 'assets/sounds/effects/start.ogg',
      'warning': 'assets/sounds/effects/warning.ogg',

    };


    await Future.wait(effects.entries.map((entry) async {
      final sound = await soloud.loadAsset(entry.value);
      _sounds[entry.key] = sound;
    }));
  }


  void play(String effect) {
    final sound = _sounds[effect];
    if (sound != null) {
      soloud.play(sound);
    }
  }


  void dispose() {
    soloud.deinit();
  }
}
