import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BitcoinPriceChart extends StatefulWidget {
  const BitcoinPriceChart({super.key});

  @override
  State<BitcoinPriceChart> createState() => BitcoinPriceChartState();
}

class BitcoinPriceChartState extends State<BitcoinPriceChart> {
  List<FlSpot> spots = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPriceData();
  }

  Future<void> fetchPriceData() async {
    final url = Uri.parse(
        'https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=7');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List prices = data['prices'];

      // Map each price entry to FlSpot
      final List<FlSpot> loadedSpots = prices.asMap().entries.map((entry) {
        final index = entry.key.toDouble();
        final price = (entry.value[1] as num).toDouble(); // USD price
        return FlSpot(index, price);
      }).toList();

      setState(() {
        spots = loadedSpots;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load price data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bitcoin Price')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  gridData: FlGridData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      barWidth: 2,
                      dotData: FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
