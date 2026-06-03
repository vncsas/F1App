import 'package:flutter/material.dart';
import 'tela_classificacao.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navegarParaClassificacao();
  }

  void _navegarParaClassificacao() async {
    await Future.delayed(Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TelaClassificacao()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Stack(   
        children: [
          Positioned(
            top: -20,
            right: -30,
            child: _linhaDecorativa(),
          ),

          Positioned(
            bottom: -20,
            left: -30,
            child: _linhaDecorativa(),
          ),
          Center(
            child: Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/F1.svg/2560px-F1.svg.png",
              width: 180,
              color: Color(0xFFE8002D),
            ),
          ),

        ],
      ),
    );
  }
  Widget _linhaDecorativa() {
    return CustomPaint(
      size: Size(150, 150),
      painter: _LinhaPainter(),
    );
  }
}
class _LinhaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFE8002D)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(
      size.width * 0.5, size.height * 0.5,
      size.width, size.height * 0.2,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}