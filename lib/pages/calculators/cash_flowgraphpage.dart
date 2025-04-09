import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CashFlowGraphPage extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const CashFlowGraphPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> generatePieData() {
      double totalIncome = data
          .where((item) => item["type"] == "Income")
          .fold(0.0, (sum, item) => sum + item["amount"]);
      double totalExpense = data
          .where((item) => item["type"] == "Expense")
          .fold(0.0, (sum, item) => sum + item["amount"]);

      return [
        PieChartSectionData(
          value: totalIncome,
          title: "Income",
          color: Colors.green,
          radius: 50,
          titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        PieChartSectionData(
          value: totalExpense,
          title: "Expenses",
          color: Colors.red,
          radius: 50,
          titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ];
    }

    List<BarChartGroupData> generateBarData() {
      return data.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> item = entry.value;
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: item["amount"].toDouble(),
              color: item["type"] == "Income" ? Colors.green : Colors.red,
              width: 16,
            ),
          ],
        );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash Flow Graph"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Chart View",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              // Pie Chart
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: generatePieData(),
                    centerSpaceRadius: 40,
                    sectionsSpace: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  "Top 3 Expenses",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              // Bar Chart
              SizedBox(
                height: 300,
                child: BarChart(
                  BarChartData(
                    barGroups: generateBarData(),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() < data.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  data[value.toInt()]["name"],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }
                            return const Text("");
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(show: true),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        left: BorderSide(color: Colors.black, width: 1),
                        bottom: BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipPadding: const EdgeInsets.all(8.0),
                       // tooltipBgColor: Colors.grey[200],
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            "${data[group.x]["name"]}\n\$${rod.toY.toInt()}",
                            const TextStyle(color: Colors.black),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}