import 'package:scoped_model/scoped_model.dart';
import 'anxiety_baby_class.dart';
import '../../api_services/anxiety_entity_service/anxiety_service.dart';
import '../../static_server_ip/static_server_ip.dart';

//This class is used with the scoped model stuff. It has the method and other things that set up the monitoring.
class ScopedAnxiety extends Model {
  AnxietyBabyClass anxietyBabyClass = new AnxietyBabyClass();
  static const String serverIP = StaticServerIP.serverIP;

  Future getData(String date) async {
    await AnxietyService.getAnxietyByDate('http://' + serverIP + '/anxieties/' + date).then((data) {
      anxietyBabyClass.data = data;
      notifyListeners();
    });
  }
  void updateGradientColor(int i) {
    anxietyBabyClass.groupValue = i;
    notifyListeners();
  }
}