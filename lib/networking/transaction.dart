import 'package:flutter/material.dart';
import 'package:flutter_final/networking/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHistoryScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Icon(Icons.arrow_back, color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
      body: transactions.when(
        data: (transactionList) {
          transactionList.sort((a, b) =>
              b['date'].toDate().millisecondsSinceEpoch -
              a['date'].toDate().millisecondsSinceEpoch);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: MediaQuery.of(context)
                      .size
                      .width, // Set the width to the entire screen width
                  child: Card(
                    color: const Color.fromARGB(
                        255, 234, 232, 232), // Grey background color
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Friday',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '22 Dec',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                '\$2,983',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Transaction History',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: transactionList.length,
                  itemBuilder: (context, index) {
                    final transaction = transactionList[index];
                    return _buildTransactionItem(context, transaction);
                  },
                ),
              ),
            ],
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (error, stack) => Text('Error: $error'),
      ),
    );
  }

  Widget _buildTransactionItem(
      BuildContext context, Map<String, dynamic> transaction) {
    final DateTime transactionDate = transaction['date'].toDate();

    String formattedDate;
    if (isSameDay(transactionDate, DateTime.now())) {
      formattedDate = 'Today';
    } else if (isSameDay(
        transactionDate, DateTime.now().subtract(Duration(days: 1)))) {
      formattedDate = 'Yesterday';
    } else {
      formattedDate =
          '${transactionDate.day} ${months[transactionDate.month]} ${transactionDate.year}';
    }

    final String paymentText = transaction['payment'] < 0
        ? '-\$${-transaction['payment']}'
        : '+\$${transaction['payment']}';

    return InkWell(
      onTap: () {
        // Handle tap on the date or amount
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage:
                  NetworkImage(transaction['image']), // Assuming image is a URL
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction['title'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(formattedDate),
              ],
            ),
            Spacer(),
            Text(
              paymentText,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color:
                      transaction['payment'] < 0 ? Colors.red : Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  final List<String> months = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
}
