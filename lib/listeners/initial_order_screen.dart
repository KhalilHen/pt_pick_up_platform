import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pt_pick_up_platform/listeners/order_listener.dart';
import 'package:pt_pick_up_platform/listeners/order_status_screen.dart';
import 'package:pt_pick_up_platform/models/enum/order_enum.dart';
// Separate screens for different order states

class OrderInitialScreen extends StatefulWidget {
  final int orderId;

  const OrderInitialScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderInitialScreen> createState() => _OrderInitialScreenState();
}

class _OrderInitialScreenState extends State<OrderInitialScreen> with TickerProviderStateMixin {
  late AnimationController spinController;
  late OrderStatusListener statusListener;
  InitialOrderState currentState = InitialOrderState.Pending;

  @override
  void initState() {
    super.initState();
    initializeAnimations();
  }

  void initalizeAnimations() {
    spinController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }

  void initializeAnimations() {
    spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Order #${widget.orderId}',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotationTransition(
              turns: spinController,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.deepOrange, width: 3, strokeAlign: BorderSide.strokeAlignOutside)),
                child: const Center(
                  child: Icon(
                    Icons.restaurant,
                    size: 40,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Text(
                    "The Restaurant will confirm your order shortly",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
