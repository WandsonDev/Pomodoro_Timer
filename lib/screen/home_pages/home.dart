import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_timer/utils/widgets.dart';
import 'package:pomodoro_timer/utils/playSound/play_sound.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int minuto = 5;
  int segundo = 5;
  int tempo = 0;
  int total = 0;
  int percent = 0;
  int selectedMin = 0;
  int selectedSec = 0;

  Color buttonCollor = Color(0xFFE63946);
  String state = "start";
  String textButton = "Iniciar Pomodoro";

  Timer? timer;
  bool rodando = false;

  @override
  void initState() {
    super.initState();
    SoundService().init();
  }

  void startTimer() {
    // Função interna que decrementa o tempo
    void tick(Timer t) {
      setState(() {
        if (segundo > 0) {
          segundo--;
        } else if (minuto > 0) {
          minuto--;
          segundo = 59;
        } else {
          // Timer terminou
          t.cancel();
          rodando = false;
          state = "start";
          textButton = "Iniciar Pomodoro";
          return;
        }
        tempo--; // decrementa contador global sempre
      });
    }

    if (state == "running") {
      // Pausar
      timer?.cancel();
      rodando = false;
      state = "paused";
      setState(() => textButton = "Retomar Pomodoro");
    } else {
      // Start ou retomar
      rodando = true;
      state = "running";
      setState(() => textButton = "Pausar Pomodoro");

      timer = Timer.periodic(const Duration(seconds: 1), tick);
    }
  }

  void picker() {
    if (state == "start") {
      showTimePickerDialog(
        context: context,
        initialMin: minuto,
        initialSec: segundo,
        onConfirm: (min, seg) {
          setState(() {
            minuto = min;
            segundo = seg;
          });
        },
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    SoundService().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1FAEE),
      appBar: buildAppBar(title: "Pomodoro Timer"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 15),
            Text(
              "Inicie seu primeiro Pomodoro hoje!",
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            GestureDetector(
              onTap: () {
                picker();
              },
              child: appProgress(
                time:
                    "${minuto.toString().padLeft(2, '0')}:${segundo.toString().padLeft(2, '0')}",
                percent: 1 - (tempo / total),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: appButton(
                    text: textButton,
                    backgroundColor: buttonCollor,
                    onPressed: () {
                      if (state == "start") {
                        SoundService().play('start');
                        total = segundo + minuto * 60;
                        tempo = total;
                      }
                      startTimer();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 50),
                  child: Visibility(
                    visible: state != "start",
                    child: GestureDetector(
                      child: Text(
                        "Cancelar pomodoro",
                        style: GoogleFonts.poppins(
                          color: Color(0xFFE63946),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        SoundService().play("warning");
                        if (rodando || state == "paused") {
                          timer?.cancel();
                          setState(() {
                            rodando = false;
                            state = "start";
                            minuto = 25;
                            segundo = 0;
                            tempo = 0;
                            total = 0;
                            textButton = "Iniciar Pomodoro";
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
