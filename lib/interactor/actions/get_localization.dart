import 'action_base.dart';
import '../accessor.dart';

class GetLocalization extends ActionBase{
  GetLocalization();

  String get localization => _localization;
  @override
  void doAction(IAccessor accessor, void onComplete(ActionBase result)){
    IDatabase storage = accessor.database;
    // storage.executeCommand(StorageCommand.GetLocalization(onEnd: (data){
    //   if(data == null) return;
    //   _localization = data as String;
    //   onComplete(this);
    // }));
  }
 String _localization = "";
}