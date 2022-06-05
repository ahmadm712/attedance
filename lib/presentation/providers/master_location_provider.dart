import 'package:attendance/data/models/office_model.dart';
import 'package:attendance/utils/constants.dart';
import 'package:flutter/widgets.dart';

class MasterLocationProvider with ChangeNotifier {
  late Office _office;
  late ResultState _state;
  String _message = '';

  Office get office => _office;

  ResultState get state => _state;
  String get message => _message;

  MasterLocationProvider() {
    _getOffice();
  }

  Future<dynamic> _getOffice() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final newOffice =
          Office(name: 'default', latitude: 0, longitude: 0, address: '');

      if (newOffice.name.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _office = newOffice;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }

  dynamic createMasterLocation({
    required String name,
    required String address,
    required double lat,
    required double long,
  }) {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final Office officeNew =
          Office(name: name, latitude: lat, longitude: long, address: address);
      if (officeNew.name.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();

        return _office = officeNew;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message =
          'Terjadi gangguan. Periksa kembali koneksi internet anda';
    }
  }

  void setOffice(Office newOffice) {
    _office = office;
    notifyListeners();
  }
}
