import 'package:flutter/material.dart';

class OrderCancelledScreen extends StatefulWidget {
  final int orderId;

  const OrderCancelledScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderCancelledScreen> createState() => _OrderCancelledScreenState();
}

class _OrderCancelledScreenState extends State<OrderCancelledScreen> with SingleTickerProviderStateMixin {
  late AnimationController shakeController;
  late Animation<double> shakeAnimation;

  @override
  void initState() {
    super.initState();
    initializeAnimations();
  }

  void initializeAnimations() {
    shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    shakeAnimation = Tween<double>(begin: -10, end: 10).animate(CurvedAnimation(parent: shakeController, curve: Curves.elasticIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          shakeController.reverse();
        }
      }));
    shakeController.forward();
  }

  @override
  void dispose() {
    shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Order Cancelled',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                    animation: shakeAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(shakeAnimation.value, 0),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red.withAlpha((0.1 * 255).round()),
                          ),
                          child: const Icon(
                            Icons.cancel,
                            size: 100,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 32,
                ),
                Text(
                  'Order Cancelled',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: const Text(
                    'Return to homepage',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {
                    // Implement support contact logic
                  },
                  child: const Text(
                    'Contact Support',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
