import 'package:flutter/material.dart';

void main() {
  runApp(EcoChallengesApp());
}

class EcoChallengesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eco-Challenges App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EcoChallengesHomePage(),
    );
  }
}

class EcoChallengesHomePage extends StatefulWidget {
  @override
  _EcoChallengesHomePageState createState() => _EcoChallengesHomePageState();
}

class _EcoChallengesHomePageState extends State<EcoChallengesHomePage> {
  // Dummy data for challenges
  List<String> challenges = [
    'Reduce plastic usage',
    'Conserve water',
    'Utilize renewable energy sources',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eco-Challenges'),
      ),
      body: ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(challenges[index]),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to challenge details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChallengeDetailsPage(challenge: challenges[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChallengeDetailsPage extends StatefulWidget {
  final String challenge;

  ChallengeDetailsPage({required this.challenge});

  @override
  _ChallengeDetailsPageState createState() => _ChallengeDetailsPageState();
}

class _ChallengeDetailsPageState extends State<ChallengeDetailsPage> {
  int yesCount = 0;
  int noCount = 0;

  @override
  Widget build(BuildContext context) {
    double percentage = yesCount / (yesCount + noCount);

    return Scaffold(
      appBar: AppBar(
        title: Text('Challenge Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Challenge: ${widget.challenge}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Track your progress and earn rewards for completing this challenge!',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            CircularProgressWithCount(percentage: percentage),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      yesCount++;
                    });
                  },
                  child: Text('Yes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      noCount++;
                    });
                  },
                  child: Text('No'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircularProgressWithCount extends StatelessWidget {
  final double percentage;

  CircularProgressWithCount({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: CustomPaint(
        painter: CircularProgressPainter(percentage: percentage),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double percentage;

  CircularProgressPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    // Draw complete progress
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    // Draw remaining progress (white color representing No)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      -90 * (3.14 / 180),
      2 * 3.14 * (1 - percentage),
      false,
      whitePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
