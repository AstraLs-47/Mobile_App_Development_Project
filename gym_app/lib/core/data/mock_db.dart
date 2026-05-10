import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/activity_model.dart';
import '../models/product_model.dart';
import '../models/announcement_model.dart';
import '../../features/progress/data/health_store.dart';

class MockDB {
  static final MockDB _instance = MockDB._internal();
  factory MockDB() => _instance;
  MockDB._internal();

  final HealthStore _healthStore = HealthStore();

  bool _initialized = false;

  // Keys
  static const _keyProducts = 'gym_products';
  static const _keyActivities = 'gym_activities';
  static const _keyAnnouncements = 'gym_announcements';
  static const _keyCategories = 'gym_categories';

  // DATA STORE (Source of truth)
  List<Product> products = [];
  List<Activity> activities = [];
  List<Announcement> announcements = [];
  List<String> categories = ['Cardio', 'Strength', 'Aerobics'];

  double totalRevenue = 12450.0;
  int totalLogouts = 42;

  bool _hasNewAnnouncements = true;

  bool get hasNewAnnouncements => _hasNewAnnouncements;

  // INIT
  Future<void> init() async {
    if (_initialized) return;

    final prefs = await SharedPreferences.getInstance();

    final prodStr = prefs.getString(_keyProducts);
    if (prodStr != null) {
      products = (json.decode(prodStr) as List)
          .map((e) => Product.fromJson(e))
          .toList();
    }

    final actStr = prefs.getString(_keyActivities);
    if (actStr != null) {
      activities = (json.decode(actStr) as List)
          .map((e) => Activity.fromJson(e))
          .toList();
    }

    final annStr = prefs.getString(_keyAnnouncements);
    if (annStr != null) {
      announcements = (json.decode(annStr) as List)
          .map((e) => Announcement.fromJson(e))
          .toList();
    }

    final catStr = prefs.getString(_keyCategories);
    if (catStr != null) {
      categories = List<String>.from(json.decode(catStr));
    }

    _initialized = true;
  }

  // SAVE
  Future<void> _saveToDisk() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _keyProducts,
      json.encode(products.map((e) => e.toJson()).toList()),
    );

    await prefs.setString(
      _keyActivities,
      json.encode(activities.map((e) => e.toJson()).toList()),
    );

    await prefs.setString(
      _keyAnnouncements,
      json.encode(announcements.map((e) => e.toJson()).toList()),
    );

    await prefs.setString(_keyCategories, json.encode(categories));
  }

  // =========================
  // PRODUCTS
  // =========================

  void addProduct(Product product) {
    products.insert(0, product);
    _saveToDisk();
  }

  void updateProduct(String id, Product updated) {
    final index = products.indexWhere((p) => p.id == id);
    if (index != -1) {
      products[index] = updated;
      _saveToDisk();
    }
  }

  void removeProduct(String id) {
    products.removeWhere((p) => p.id == id);
    _saveToDisk();
  }

  // =========================
  // ACTIVITIES
  // =========================

  void addActivity(Activity activity) {
    activities.insert(0, activity);
    _saveToDisk();
  }

  void updateActivity(String id, Activity updated) {
    final index = activities.indexWhere((a) => a.id == id);
    if (index != -1) {
      activities[index] = updated;
      _saveToDisk();
    }
  }

  void removeActivity(String id) {
    activities.removeWhere((a) => a.id == id);
    _saveToDisk();
  }

  // =========================
  // ANNOUNCEMENTS
  // =========================

  void addAnnouncement(Announcement announcement) {
    announcements.insert(0, announcement);
    _hasNewAnnouncements = true;
    _saveToDisk();
  }

  void updateAnnouncement(String id, Announcement updated) {
    final index = announcements.indexWhere((a) => a.id == id);
    if (index != -1) {
      announcements[index] = updated;
      _saveToDisk();
    }
  }

  void removeAnnouncement(String id) {
    announcements.removeWhere((a) => a.id == id);
    _saveToDisk();
  }

  void markAnnouncementsAsViewed() {
    _hasNewAnnouncements = false;
  }

  // =========================
  // SIMPLE STATS
  // =========================

  int getTotalProducts() => products.length;

  void trackLogout() {
    totalLogouts++;
    _saveToDisk();
  }

  // =========================
  // HEALTH (unchanged usage)
  // =========================

  double calculateAvgBMI() {
    if (_healthStore.records.isEmpty) return 0.0;
    final total = _healthStore.records.fold(0.0, (sum, r) => sum + r.bmi);
    return total / _healthStore.records.length;
  }

  double calculateAvgHR() {
    if (_healthStore.records.isEmpty) return 0.0;
    final total = _healthStore.records.fold(0.0, (sum, r) => sum + r.heartRate);
    return total / _healthStore.records.length;
  }
}
