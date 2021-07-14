import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';


class ScanListProvider extends ChangeNotifier {

  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async{
    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    //asignar el ID de la base de datos al modelo. 
    nuevoScan.id = id;

    if (this.tipoSeleccionado == nuevoScan.tipo){
  
    this.scans.add(nuevoScan);
    notifyListeners();
    }
    return nuevoScan;
  }

  cargarScans()async {
    final scans = await DBProvider.db.getTodosLosScans();
    this.scans = [...scans];
    notifyListeners();

  }

  cargarScanTipo(String tipo) async {

    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();

  }

  borratTodos()async {

    await DBProvider.db.deleteAllScan();
    this.scans = [];
    notifyListeners();

  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    
    
  }
}