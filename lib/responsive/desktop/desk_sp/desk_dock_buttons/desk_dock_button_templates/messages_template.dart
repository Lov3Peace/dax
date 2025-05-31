import 'package:flutter/material.dart';

class CustomDataTable extends StatelessWidget {
  final List<String> headers;
  final List<List<Widget>> rows;
  final double columnSpacing;
  final double horizontalMargin;
  final double fontSize;
  final double topPadding;
  final BoxDecoration? decoration;

  const CustomDataTable({
    super.key,
    required this.headers,
    required this.rows,
    this.columnSpacing = 40.0,
    this.horizontalMargin = 40.0,
    this.fontSize = 14.0,
    this.topPadding = 8.0,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: decoration ??
          BoxDecoration(
            color: const Color.fromARGB(70, 32, 32, 40),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white24),
          ),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DataTable(
              dividerThickness: 0.25,
              columnSpacing: columnSpacing,
              horizontalMargin: horizontalMargin,
              columns: headers
                  .map(
                    (header) => DataColumn(
                      label: Text(
                        header,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: fontSize,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              rows: rows
                  .map(
                    (row) => DataRow(
                      cells: row
                          .map(
                            (cell) => DataCell(
                              Padding(
                                padding: EdgeInsets.only(top: topPadding),
                                child: cell,
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
