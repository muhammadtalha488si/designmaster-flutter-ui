
import 'package:flutter/material.dart';

import '../../models/order_model.dart';
import '../../providers/order_provider.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final provider = OrderProvider();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track Order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: AnimatedBuilder(
        animation: provider,
        builder: (context, child) {
          final order = provider.getOrder(orderId);

          if (order == null) {
            return const Center(
              child: Text('Order could not be found.'),
            );
          }

          final isDelivered =
              order.statusIndex == OrderModel.statuses.length - 1;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF263B80),
                        Color(0xFF5575D9),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ORDER STATUS',
                        style: TextStyle(
                          color: Colors.white70,
                          letterSpacing: 1,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        order.status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Order #${order.id}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                const Text(
                  'Tracking Progress',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 22),

                ...List.generate(
                  OrderModel.statuses.length,
                  (index) {
                    final completed = index <= order.statusIndex;
                    final isLast =
                        index == OrderModel.statuses.length - 1;

                    return _trackingStep(
                      title: OrderModel.statuses[index],
                      description: _description(index),
                      completed: completed,
                      isLast: isLast,
                    );
                  },
                ),

                const SizedBox(height: 24),

                const Text(
                  'Delivery Information',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 14),

                _infoRow(Icons.person_outline, order.customerName),
                _infoRow(Icons.phone_outlined, order.phone),
                _infoRow(Icons.location_on_outlined, order.address),

                const SizedBox(height: 24),

                const Text(
                  'Order Summary',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                ...order.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${item.productName} × ${item.quantity}',
                          ),
                        ),
                        Text(
                          'Rs. ${item.total.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const Divider(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rs. ${order.total.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Demo tracking: order progress is simulated locally. '
                    'It does not represent a real delivery.',
                    style: TextStyle(fontSize: 12),
                  ),
                ),

                if (!isDelivered) ...[
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        provider.advanceDemoStatus(order.id);
                      },
                      icon: const Icon(Icons.update),
                      label: const Text('Advance Demo Status'),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _trackingStep({
    required String title,
    required String description,
    required bool completed,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 36,
            child: Column(
              children: [
                Icon(
                  completed
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: completed ? Colors.green : Colors.grey,
                  size: 25,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: completed
                          ? Colors.green
                          : Colors.grey.shade300,
                    ),
                  ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28, left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: completed ? Colors.green : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _description(int index) {
    switch (index) {
      case 0:
        return 'Your demo order has been placed.';
      case 1:
        return 'Your order has been confirmed.';
      case 2:
        return 'Your products are being prepared.';
      case 3:
        return 'Your order is marked as shipped.';
      case 4:
        return 'Your order is marked as delivered.';
      default:
        return '';
    }
  }

  Widget _infoRow(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
