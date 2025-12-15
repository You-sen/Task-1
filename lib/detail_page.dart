import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isDataView = true;
  bool _isTodayData = true;
  bool _isDataCostInfoExpanded = true;
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

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
              const SizedBox(height: 32),
              if (_isDataView) _buildDataViewContent() else _buildRevenueViewContent(),
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
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => setState(() => _isDataView = true),
              style: TextButton.styleFrom(
                backgroundColor: _isDataView ? Colors.blue : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Data View',
                style: TextStyle(color: _isDataView ? Colors.white : Colors.grey),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () => setState(() => _isDataView = false),
              style: TextButton.styleFrom(
                backgroundColor: !_isDataView ? Colors.blue : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Revenue View',
                style: TextStyle(color: !_isDataView ? Colors.white : Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataViewContent() {
    return Column(
      children: [
        _buildCircularProgress(),
        const SizedBox(height: 32),
        _buildDataSelection(),
        const SizedBox(height: 16),
        if (_isTodayData) _buildTodayData(),
        if (!_isTodayData) _buildCustomDateData(),
      ],
    );
  }

  Widget _buildRevenueViewContent() {
    return Column(
      children: [
        _buildRevenueCircularProgress(),
        const SizedBox(height: 32),
        _buildDataCostInfoCard(),
      ],
    );
  }

  Widget _buildCircularProgress() {
    return CircularPercentIndicator(
      radius: 80.0,
      lineWidth: 15.0,
      percent: 0.57,
      center: const Text(
        '57.00\nkWh/Sqft',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      progressColor: Colors.blue,
      backgroundColor: Colors.blue.shade100,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  Widget _buildDataSelection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => setState(() => _isTodayData = true),
              child: Row(
                children: [
                  Radio<bool>(
                    value: true,
                    groupValue: _isTodayData,
                    onChanged: (val) => setState(() => _isTodayData = true),
                    activeColor: Colors.blue,
                  ),
                  const Text('Today Data'),
                ],
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () => setState(() => _isTodayData = false),
              child: Row(
                children: [
                  Radio<bool>(
                    value: false,
                    groupValue: _isTodayData,
                    onChanged: (val) => setState(() => _isTodayData = false),
                    activeColor: Colors.blue,
                  ),
                  const Text('Custom Date Data'),
                ],
              ),
            ),
          ],
        ),
        if (!_isTodayData)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                Expanded(child: _buildDateField('From Date', _fromDateController)),
                const SizedBox(width: 16),
                Expanded(child: _buildDateField('To Date', _toDateController)),
                const SizedBox(width: 16),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                      color: Colors.blue,
                    ))
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDateField(String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          controller.text = "${picked.toLocal()}".split(' ')[0];
        }
      },
    );
  }

  Widget _buildTodayData() {
    return _buildEnergyChartCard('5.53 kW', 'Energy Chart');
  }

  Widget _buildCustomDateData() {
    return Column(
      children: [
        _buildEnergyChartCard('20.05 kW', 'Energy Chart'),
        const SizedBox(height: 16),
        _buildEnergyChartCard('5.53 kW', 'Energy Chart'),
      ],
    );
  }

  Widget _buildEnergyChartCard(String value, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildDataRow('Data A', '2798.50 (29.53%)', '35689 ৳'),
          _buildDataRow('Data B', '72598.50 (35.39%)', '5259689 ৳'),
          _buildDataRow('Data C', '6598.36 (83.90%)', '5698756 ৳'),
          _buildDataRow('Data D', '6598.26 (36.59%)', '356987 ৳'),
        ],
      ),
    );
  }

  Widget _buildDataRow(String title, String data, String cost, [Color? color]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          if (color != null)
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          if (color != null) const SizedBox(width: 8),
          Text(title),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Data : $data'),
              Text('Cost : $cost'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRevenueCircularProgress() {
    return CircularPercentIndicator(
      radius: 80.0,
      lineWidth: 15.0,
      percent: 0.8,
      center: const Text(
        '8897455\ntk',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      progressColor: Colors.blue,
      backgroundColor: Colors.blue.shade100,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }

  Widget _buildDataCostInfoCard() {
    return Container(
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
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Data & Cost Info', style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: IconButton(
              icon: Icon(_isDataCostInfoExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.blue),
              onPressed: () {
                setState(() {
                  _isDataCostInfoExpanded = !_isDataCostInfoExpanded;
                });
              },
            ),
          ),
          if (_isDataCostInfoExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  _buildDataCostRow('Data 1', '2798.50 (29.53%)', '35689 ৳'),
                  _buildDataCostRow('Data 2', '2798.50 (29.53%)', '35689 ৳'),
                  _buildDataCostRow('Data 3', '2798.50 (29.53%)', '35689 ৳'),
                  _buildDataCostRow('Data 4', '2798.50 (29.53%)', '35689 ৳'),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget _buildDataCostRow(String title, String data, String cost) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('$title : $data'), Text('Cost : $cost')],
          ),
        ],
      ),
    );
  }
}
