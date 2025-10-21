import 'package:flutter/material.dart';
import 'package:dr_time/domain/drug_info.dart';

class DrugDetailPage extends StatelessWidget {
  final DrugInfo drugInfo;

  const DrugDetailPage({super.key, required this.drugInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(drugInfo.brandName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              drugInfo.brandName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Generic Name: ${drugInfo.genericName}',
              style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            if (drugInfo.manufacturerName != null) ...[
              const SizedBox(height: 8),
              Text('Manufacturer: ${drugInfo.manufacturerName}', style: const TextStyle(fontSize: 16)),
            ],
            if (drugInfo.productType != null) ...[
              const SizedBox(height: 8),
              Text('Product Type: ${drugInfo.productType}', style: const TextStyle(fontSize: 16)),
            ],
            if (drugInfo.indicationsAndUsage.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Indications and Usage:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ...drugInfo.indicationsAndUsage.map((indication) => Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                child: Text('- $indication', style: const TextStyle(fontSize: 16)),
              )).toList(),
            ],
            const SizedBox(height: 20),
            // You can add more details here from the DrugInfo object
          ],
        ),
      ),
    );
  }
}