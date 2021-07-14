import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_buttom.dart';

import 'direcciones_page.dart';
import 'mapas_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(icon: Icon(Icons.delete_forever), onPressed: () {
            final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

            scanListProvider.borratTodos();
            
          })
        ],
      ),
      body: _HomePageBody(),
      
     bottomNavigationBar: CustomNavigationBar(),
     floatingActionButton: ScanButton(),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context)  {

    //obteener selected menu OPT

    final uiProvider = Provider.of<UiProvider>(context);
    
    //cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //usar el scanListProvider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    //TODO temporal leer la base de datos
    /* final tempScan = new ScanModel(valor: 'http://google.com');*/
    
    //final borrarTodo = DBProvider.db.deleteAllScan().then(print); 
    

    switch (currentIndex){

      case 0: 
      scanListProvider.cargarScanTipo('geo');
        return MapasPage();

      case 1: 
      scanListProvider.cargarScanTipo('http');
      return DireccionesPage();

      default:

      return MapasPage();
    }
  }
}