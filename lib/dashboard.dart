import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'detail_page.dart';
import 'more_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F8),
      appBar: AppBar(
        title: const Text('SCM'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTopButtons(),
              const SizedBox(height: 16),
              _buildElectricityCard(),
              const SizedBox(height: 16),
              _buildSourceLoadButtons(),
              const SizedBox(height: 16),
              _buildScrollableDataContainer(context),
              const SizedBox(height: 16),
              _buildBottomButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopButtons() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Summery',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'SLD',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Data',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElectricityCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Electricity',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 15.0,
            percent: 0.75,
            center: const Text(
              'Total Power\n5.53 kw',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            progressColor: Colors.blue,
            backgroundColor: Colors.blue.shade100,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }

  Widget _buildSourceLoadButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Source'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Load'),
          ),
        ),
      ],
    );
  }

  Widget _buildScrollableDataContainer(BuildContext context) {
    return Container(
      height: 200, // Set a fixed height to make it scrollable
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDataRow(context, 'Data Type 1', 'Active', '55505.63', '58805.63', Icons.solar_power, Colors.green),
              _buildDataRow(context, 'Data Type 2', 'Active', '55505.63', '58805.63', Icons.battery_charging_full, Colors.green),
              _buildDataRow(context, 'Data Type 3', 'Inactive', '55505.63', '58805.63', Icons.power, Colors.red),
              _buildDataRow(context, 'Data Type 4', 'Active', '12345.67', '23456.78', Icons.lightbulb, Colors.green),
              _buildDataRow(context, 'Data Type 5', 'Inactive', '98765.43', '87654.32', Icons.warning, Colors.red),
              _buildDataRow(context, 'Data Type 6', 'Active', '54321.09', '65432.10', Icons.ac_unit, Colors.green),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataRow(BuildContext context, String title, String status, String data1, String data2, IconData icon, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 40),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Text('($status)', style: TextStyle(color: statusColor)),
                ],
              ),
              Text('Data 1 : $data1'),
              Text('Data 2 : $data2'),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 3,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildBottomButton(context, 'Analysis Pro', Icons.analytics),
        _buildBottomButton(context, 'G. Generator', Icons.power_input),
        _buildBottomButton(context, 'Plant Summery', Icons.factory),
        _buildBottomButton(context, 'Natural Gas', Icons.local_fire_department),
        _buildBottomButton(context, 'D. Generator', Icons.power_input),
        _buildBottomButton(context, 'Water Process', Icons.water),
      ],
    );
  }

  Widget _buildBottomButton(BuildContext context, String title, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MorePage()),
        );
      },
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
