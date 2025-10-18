import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro_timer/utils/widgets.dart';
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
  Color buttonCollor = Color(0xFFE63946);
  String state = "start";
  String textButton = "Iniciar Pomodoro";

  Timer? timer;
  bool rodando = false;

  void startTimer() {
    if (state == "paused") {
      // Retomar
      rodando = true;
      state = "running"; // atualiza antes do texto
      setState(() {
        textButton = "Pausar Pomodoro";
      });

      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        setState(() {
          if (segundo > 0) {
            segundo--;
          } else {
            if (minuto > 0) {
              minuto--;
              segundo = 59;
            } else {
              t.cancel();
              rodando = false;
              state = "start";
              textButton = "Iniciar Pomodoro";
            }
          }
        });
      });
    } else if (state == "running") {
      // Pausar
      timer?.cancel();
      rodando = false;
      state = "paused";
      setState(() {
        textButton = "Retomar Pomodoro";
      });
    } else if (state == "start") {
      // Iniciar do início
      rodando = true;
      state = "running";
      setState(() {
        textButton = "Pausar Pomodoro";
      });

      timer = Timer.periodic(const Duration(seconds: 1), (t) {
        setState(() {
          if (segundo > 0) {
            segundo--;
          } else {
            if (minuto > 0) {
              minuto--;
              segundo = 59;
            } else {
              t.cancel();
              rodando = false;
              state = "start";
              textButton = "Iniciar Pomodoro";
            }
          }
        });
        tempo--;
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
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
            appProgress(
              time:
                  "${minuto.toString().padLeft(2, '0')}:${segundo.toString().padLeft(2, '0')}",
              percent: 1 - (tempo / total),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 50),
              child: appButton(
                text: textButton,
                backgroundColor: buttonCollor,
                onPressed: () {
                  if (state == "start") {
                    total = segundo + minuto * 60;
                    tempo = total;
                  }
                  startTimer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
