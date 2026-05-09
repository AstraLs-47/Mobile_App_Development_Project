// Project imports:
import '../models/graph_dataset.dart';
import '../models/graph_point.dart';

class GraphTransformers {
  GraphTransformers._();

  // Example admin transformer: User Growth over time
  static GraphDataset adminUserEngagement(List<double> rawData) {
    final points = rawData.asMap().entries.map((e) {
      return GraphPoint(
        x: DateTime.now().subtract(Duration(days: 6 - e.key)),
        y: e.value,
        label: "Day ${e.key}",
      );
    }).toList();

    return GraphDataset(title: 'User Activity', points: points);
  }

  static GraphDataset adminCategoryDistribution(Map<String, double> data) {
    final points = data.entries.map((e) {
      return GraphPoint(
        x: DateTime.now(), // Irrelevant for pie charts
        y: e.value,
        label: e.key,
      );
    }).toList();

    return GraphDataset(title: 'By Category', points: points);
  }

  static GraphDataset adminProductsByType(
    List<double> data,
    List<String> labels,
  ) {
    final points = data.asMap().entries.map((e) {
      return GraphPoint(
        x: DateTime.now(), // Irrelevant for bar charts
        y: e.value,
        label: e.key < labels.length ? labels[e.key] : '',
      );
    }).toList();

    return GraphDataset(title: 'Products by Type', points: points);
  }
}
