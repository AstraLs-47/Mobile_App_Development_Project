// Project imports:
import '../../../core/services/mock_db.dart';

class DashboardService {
  final MockDB _db = MockDB();

  Future<Map<String, dynamic>> fetchDashboardStats() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'avgBmi': _db.calculateAvgBMI(),
      'avgHr': _db.calculateAvgHR(),
      'totalActivities': _db.activities.length,
      'hasNewAnnouncements': _db.hasNewAnnouncements,
    };
  }
}
