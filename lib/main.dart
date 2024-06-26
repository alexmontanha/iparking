import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iparking/cartas.dart';
import 'package:iparking/cartas_service.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Meu App',
      home: TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color(Colors.white.value),
        backgroundColor: Color(Colors.orange.value),
        title: const Column(
          children: [
            Text(
              'iParking',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Sua solução de estacionamento com IA',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.orange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text("Teste de texto",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NovaTela()));
                },
                child: Image.asset("assets/images/car01.jpg",
                    width: 200.0, height: 200.0),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NovaTela()));
                },
                child: Image.asset("assets/images/parking01.jpg",
                    width: 200.0, height: 200.0),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NovaTela()));
                },
                child: Image.asset("assets/images/parking02.jpg",
                    width: 200.0, height: 200.0),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
      ),
    );
  }
}

class NovaTela extends StatelessWidget {
  late Future<Cartas> cartas;

  NovaTela({super.key}) {
    CartasService cartasService = CartasService();
    cartas = cartasService.getCartas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tela'),
      ),
      body: Center(
        child: FutureBuilder<Cartas>(
          future: cartas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Text('Deck ID: ${snapshot.data!.deckId}'),
                  Text('Remaining: ${snapshot.data!.remaining}'),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.cards.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data!.cards[index].value),
                          subtitle: Text(snapshot.data!.cards[index].suit),
                          leading: Image.network(
                              snapshot.data!.cards[index].images.png),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
