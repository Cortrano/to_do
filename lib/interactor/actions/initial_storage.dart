import 'action_base.dart';
import '../accessor.dart';

class InitialStorage extends ActionBase{
  InitialStorage(this._localPath);

  @override
  void doAction(IAccessor accessor, void onComplete(ActionBase result)){
    IDatabase database = accessor.database;
    database.initStorage(_localPath, (){
      accessor.initialize();
      onComplete(this);
    });
  }
  String _localPath;
}