import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int i) =>uiProvider.selectedMenuOpt = i,
      currentIndex: currentIndex,
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          label: 'Mapa', 
          icon: Icon(Icons.map)),
          BottomNavigationBarItem(
          label: 'Direcciones', 
          icon: Icon(Icons.compass_calibration)),
         
      ],
      
    );
  }
}