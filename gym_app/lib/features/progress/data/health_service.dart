// Project imports:
import 'health_store.dart';
import '../domain/health_record_model.dart';

class HealthService {
  final HealthStore _store = HealthStore();

  Future<List<HealthRecord>> fetchHealthRecords() async {
    await Future.delayed(const Duration(seconds: 1));
    return _store.records;
  }

  Future<void> addHealthRecord(HealthRecord record) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _store.addRecord(record);
  }
}
