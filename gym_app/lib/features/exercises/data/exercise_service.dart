// Project imports:
import '../../../core/services/mock_db.dart';
import '../../../core/models/activity_model.dart';

class ExerciseService {
  final MockDB _db = MockDB();

  Future<List<Activity>> fetchActivities() async {
    return _db.activities.map((a) => Activity.fromJson(a)).toList();
  }

  Future<void> addActivity(Activity activity) async {
    _db.addActivity(activity.toJson().map((k, v) => MapEntry(k, v.toString())));
  }

  Future<void> updateActivity(Activity activity) async {
    _db.updateActivity(activity.id, activity.toJson().map((k, v) => MapEntry(k, v.toString())));
  }

  Future<void> deleteActivity(String id) async {
    _db.removeActivity(id);
  }
}
