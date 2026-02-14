import 'dart:async';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/util/imports.dart';

import '../live_chart.dart';

class CryptoWalletSection2 extends StatefulWidget {
  final String selectedAsset; // "BTC", "ETH", "SOL", "XRP"

  const CryptoWalletSection2({
    super.key,
    required this.selectedAsset,
  });

  @override
  State<CryptoWalletSection2> createState() => _CryptoWalletSection2State();
}

class _CryptoWalletSection2State extends State<CryptoWalletSection2> {
  // Independent ranges for each chart
  String portfolioRange = "1D";
  String marketRange = "1D";
  final List<String> ranges = ["1D", "7D", "1M", "3M", "1Y"];

  late final Map<String, LiveChartController> charts;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    charts = {
      "BTC": LiveChartController(),
      "ETH": LiveChartController(),
      "SOL": LiveChartController(),
      "XRP": LiveChartController(),
    };

    _startPolling();
  }

  void _startPolling() {
    _timer = Timer.periodic(
      const Duration(seconds: 6),
      (_) => _fetchPrices(),
    );
  }

  Future<void> _fetchPrices() async {
    final uri = Uri.parse(
      "https://api.coingecko.com/api/v3/simple/price"
      "?ids=bitcoin,ethereum,solana,ripple"
      "&vs_currencies=usd",
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) return;

    final data = json.decode(response.body);

    charts["BTC"]!.addPrice((data["bitcoin"]["usd"] as num).toDouble());
    charts["ETH"]!.addPrice((data["ethereum"]["usd"] as num).toDouble());
    charts["SOL"]!.addPrice((data["solana"]["usd"] as num).toDouble());
    charts["XRP"]!.addPrice((data["ripple"]["usd"] as num).toDouble());
  }

  @override
  void didUpdateWidget(CryptoWalletSection2 oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedAsset != widget.selectedAsset) {
      marketRange = "1D";
    }
  }

  // Dummy data for now – you can replace with real portfolio & market data later
  List<double> _generateSeries(String range, {bool isPortfolio = false}) {
    // For now just generate some synthetic curves based on range
    int points;
    switch (range) {
      case "7D":
        points = 20;
        break;
      case "1M":
        points = 30;
        break;
      case "3M":
        points = 40;
        break;
      case "1Y":
        points = 50;
        break;
      case "1D":
      default:
        points = 15;
        break;
    }

    // simple synthetic trending data – replace with real values later
    return List<double>.generate(points, (i) {
      final t = i / (points - 1);
      if (isPortfolio) {
        // smoother “portfolio” line
        return 1000 + 150 * (t * t) + 40 * (i.isEven ? 1 : -1);
      } else {
        // "market" line, a bit more volatile
        return 1000 + 200 * t + 120 * (i.isOdd ? 1 : -1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final portfolioData = _generateSeries(portfolioRange, isPortfolio: true);
    final marketData = _generateSeries(marketRange, isPortfolio: false);

    final assetNames = {
      "BTC": "Bitcoin",
      "ETH": "Ethereum",
      "SOL": "Solana",
      "XRP": "XRP",
    };

    final assetName = assetNames[widget.selectedAsset] ?? widget.selectedAsset;

    return Padding(
      padding: EdgeInsets.only(right: 1.w(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 2.5.h(context),
        children: [
          // ----------------- PORTFOLIO CHART -----------------

          _buildChartCard(
            key: const ValueKey("portfolio"),
            context: context,
            title: "Portfolio Performance",
            subtitle: "Total crypto value over time",
            range: portfolioRange,
            onRangeChanged: (r) {
              setState(() => portfolioRange = r);
            },
            series: portfolioData,
          ),

          // ----------------- MARKET / ASSET CHART -----------------

          // AnimatedSwitcher(
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            child: _buildChartCard(
              key: ValueKey("market-${widget.selectedAsset}"), // 🔥
              context: context,
              title: "$assetName (${widget.selectedAsset})",
              subtitle: "Market performance • ${widget.selectedAsset}",
              range: marketRange,
              onRangeChanged: (r) {
                setState(() => marketRange = r);
              },
              series: marketData,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // CARD WRAPPER FOR EACH CHART
  // ----------------------------------------------------------
  Widget _buildChartCard({
    Key? key,
    required BuildContext context,
    required String title,
    required String subtitle,
    required String range,
    required ValueChanged<String> onRangeChanged,
    required List<double> series,
  }) {
    return Container(
      key: key,
      height: 35.h(context),
      width: 30.w(context),
      padding: EdgeInsets.all(2.w(context)),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1B26),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: blue.withOpacity(.4),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: blue.withOpacity(.35),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 1.5.h(context),
        children: [
          // Title + subtitle
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: .5.h(context),
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 4.sp(context),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 2.5.sp(context),
                  color: Colors.white70,
                ),
              ),
            ],
          ),

          // Time range selector row
          Row(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: ranges.map((r) {
              final bool isActive = (r == range);
              return Padding(
                padding: EdgeInsets.only(left: 1.5.w(context)),
                child: GestureDetector(
                  onTap: () => onRangeChanged(r),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    padding: EdgeInsets.symmetric(
                      horizontal: 1.w(context),
                      vertical: .6.h(context),
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? blue.withOpacity(.85)
                          : const Color(0xFF24283B),
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: blue.withOpacity(.6),
                                blurRadius: 12,
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      r,
                      style: TextStyle(
                        fontSize: 2.3.sp(context),
                        fontWeight: FontWeight.w600,
                        color: isActive ? Colors.white : Colors.white70,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          // Expanded chart area
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(top: 1.h(context)),
                child: buildLiveChart(widget.selectedAsset)),
          ),
        ],
      ),
    );
  }

  // // ----------------------------------------------------------
  // // NEON LINE CHART (FL_CHART)
  // // ----------------------------------------------------------
  // Widget _buildLineChart(BuildContext context, List<double> series) {
  //   if (series.isEmpty) {
  //     return const Center(
  //       child: Text(
  //         "No data yet",
  //         style: TextStyle(color: Colors.white54),
  //       ),
  //     );
  //   }
  //
  //   final spots = List<FlSpot>.generate(
  //     series.length,
  //     (i) => FlSpot(i.toDouble(), series[i]),
  //   );
  //
  //   final minY = series.reduce((a, b) => a < b ? a : b);
  //   final maxY = series.reduce((a, b) => a > b ? a : b);
  //
  //   return LineChart(
  //     LineChartData(
  //       minY: minY * 0.98,
  //       maxY: maxY * 1.02,
  //       borderData: FlBorderData(show: false),
  //       gridData: FlGridData(show: false),
  //       titlesData: FlTitlesData(show: false),
  //       lineTouchData: LineTouchData(
  //         handleBuiltInTouches: true,
  //         touchTooltipData: LineTouchTooltipData(
  //           tooltipBgColor: Colors.black.withOpacity(.75),
  //           tooltipRoundedRadius: 10,
  //           fitInsideVertically: true,
  //           fitInsideHorizontally: true,
  //           getTooltipItems: (spots) {
  //             return spots.map((s) {
  //               final v = s.y.toStringAsFixed(2);
  //               return LineTooltipItem(
  //                 "\$$v",
  //                 TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 2.5.sp(context),
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               );
  //             }).toList();
  //           },
  //         ),
  //       ),
  //       lineBarsData: [
  //         LineChartBarData(
  //           spots: spots,
  //           isCurved: true,
  //           barWidth: 3,
  //           isStrokeCapRound: true,
  //           gradient: LinearGradient(
  //             colors: [
  //               blue.withOpacity(.95),
  //               purp.withOpacity(.8),
  //             ],
  //             begin: Alignment.centerLeft,
  //             end: Alignment.centerRight,
  //           ),
  //           dotData: FlDotData(show: false),
  //           belowBarData: BarAreaData(
  //             show: true,
  //             gradient: LinearGradient(
  //               begin: Alignment.topCenter,
  //               end: Alignment.bottomCenter,
  //               colors: [
  //                 blue.withOpacity(.25),
  //                 purp.withOpacity(.08),
  //                 Colors.transparent,
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //

  Widget buildLiveChart(String asset) {
    final controller = charts[asset]!;

    return ValueListenableBuilder<List<FlSpot>>(
      valueListenable: controller.points,
      builder: (_, spots, __) {
        if (spots.isEmpty) {
          return const Center(
            child: Text(
              "Waiting for data…",
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        final minY = spots.map((e) => e.y).reduce((a, b) => a < b ? a : b);
        final maxY = spots.map((e) => e.y).reduce((a, b) => a > b ? a : b);

        // 🔥 Add padding so the line breathes
        final padding = (maxY - minY) * 0.2;

        return LineChart(
          LineChartData(
            minX: spots.first.x,
            maxX: spots.last.x,
            minY: minY - padding,
            maxY: maxY + padding,
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            lineTouchData: LineTouchData(
              handleBuiltInTouches: true,
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 3,
                dotData: FlDotData(show: false),
                gradient: LinearGradient(
                  colors: [
                    blue.withOpacity(.9),
                    purp.withOpacity(.7),
                  ],
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      blue.withOpacity(.25),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
