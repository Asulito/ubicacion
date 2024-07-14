import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'home_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late Function goToTab;

  Color primaryColor = const Color(0xFFB39DDB);
  Color secondColor = const Color(0xFF9575CD);

  void onDonePress() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  void onTabChangeCompleted(index) {
  }

  List<Widget> generateListCustomTabs() {
    return [
      Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 60),
            Image.asset(
              "assets/welcome.png",
              height: 300,
            ),
            const SizedBox(height: 20),
            Text(
              "¡Bienvenido!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Esta aplicación te permite conocer tu ubicación actual en tiempo real y actualizarla con solo un toque.",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 60),
            Image.asset(
              "assets/update.png",
              height: 300,
            ),
            const SizedBox(height: 20),
            Text(
              "Actualización fácil",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondColor,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Presiona el botón de actualización para obtener tu dirección más reciente.",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 60),
            Image.asset(
              "assets/settings.png",
              height: 300,
            ),
            const SizedBox(height: 20),
            Text(
              "¿Cómo empezar?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: secondColor,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Para ofrecerte la mejor experiencia, necesitamos acceder a tu ubicación. Asegúrate de otorgar los permisos necesarios cuando se te soliciten.",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      key: UniqueKey(),

      // Done button
      onDonePress: onDonePress,

      // Custom tabs
      listCustomTabs: generateListCustomTabs(),
      backgroundColorAllTabs: Colors.white,
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: const BouncingScrollPhysics(),
      onTabChangeCompleted: onTabChangeCompleted,
    );
  }
}
