import 'package:flutter/material.dart';
import 'package:powerupdata/screens/GraphicsPage.dart';
import 'package:powerupdata/screens/HomePage.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarExampleState createState() => _BottomNavBarExampleState();
}

class _BottomNavBarExampleState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // Lista de páginas disponibles
  final List<Widget> _pages = [
    const HomePage(),
    const GraphicsPage(),
  ];

  // Método para cambiar de página
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Mostrar la página seleccionada
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          selectedFontSize: 5,
          unselectedFontSize: 5,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Gráficos',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          onTap: _onItemTapped,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(4.0),
        child: FloatingActionButton(
          elevation: 2,
          hoverElevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          splashColor: Colors.orange,
          tooltip: 'Añade un cliente',
          onPressed: () {
            _onItemTapped(0);
          },
          child: const Icon(Icons.person_add),
        ),
      ),
    );
  }
}
