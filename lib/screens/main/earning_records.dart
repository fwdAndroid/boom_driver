import 'package:flutter/material.dart';

class EarningsScreen extends StatefulWidget {
  @override
  _EarningsScreenState createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> earningsData = [
    {'title': 'Total Earnings', 'amount': 1234.56},
    {'title': 'Pending Payments', 'amount': 200.00},
    {'title': 'Completed Payments', 'amount': 1034.56},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: earningsData.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earnings'),
        bottom: TabBar(
          controller: _tabController,
          tabs: earningsData
              .map((earning) => Tab(text: earning['title']))
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: earningsData
            .map((earning) => _EarningsTab(earning: earning))
            .toList(),
      ),
    );
  }
}

class _EarningsTab extends StatelessWidget {
  final Map<String, dynamic> earning;

  const _EarningsTab({required this.earning});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(earning['title']),
            trailing: Text('\$${earning['amount'].toStringAsFixed(2)}'),
          ),
        );
      },
    );
  }
}
