import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
import 'package:pt_pick_up_platform/listeners/order_time_line.dart';
import 'order_listener.dart';
import 'package:pt_pick_up_platform/models/enum/order_enum.dart';

class OrderStatusScreen extends StatefulWidget {
  final int orderId;

  const OrderStatusScreen({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> with TickerProviderStateMixin {
  late OrderStatusListener statusListener;
  late AnimationController pulseController;
  late AnimationController progressController;

  CustomerOrderStatus currentStatus = CustomerOrderStatus.Confirmed;

  @override
  void initState() {
    super.initState();
    setupStatusListener();

    initializeAnimations();
  }

  void setupStatusListener() {
    statusListener = OrderStatusListener(widget.orderId); //TODO replace later with orderId
    statusListener.startListening((status) {
      setState(() {
        switch (status) {
          case OrderStatus.Accepted:
            updateStatus(CustomerOrderStatus.Confirmed);
            break;

          case OrderStatus.Kitchen:
            updateStatus(CustomerOrderStatus.Preparing);

            break;

          case OrderStatus.ReadForPickUp:
            updateStatus(CustomerOrderStatus.ReadyForPickUp);
            break;

          case OrderStatus.Completed:
            updateStatus(CustomerOrderStatus.Completed);
            break;

          default:
            print('Status not found');
            break;
        }
      });
    });
  }

  void updateStatus(CustomerOrderStatus newStatus) {
    if (currentStatus != newStatus) {
      currentStatus = newStatus;
      print('Status Updated: $currentStatus');
      // HapticFeedback.Me();
      // HapticFeedback.acmediumImpact();
      HapticFeedback.mediumImpact();
    }
  }

  void initializeAnimations() {
    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    statusListener.dispose();

    pulseController.dispose();
    progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Order #10}',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          //Status Header
          StatusHeader(),

          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  timeEstimate(),
                  const SizedBox(
                    height: 24,
                  ),
                  statusTimeLine(),
                ],
              ),
            ),
          ))
        ],
      )),
    );
  }

  Widget statusTimeLine() {
    return Column(
      children: CustomerOrderStatus.values.map((status) {
        final isCompleted = status.index <= currentStatus.index;
        final isActive = status == currentStatus;
        return OrderTimeLine(status: status, isCompleted: isCompleted, isActive: isActive);
      }).toList(),
    );
  }

  Widget StatusHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey.withAlpha((0.1 * 255).round()), spreadRadius: 1, blurRadius: 10),
      ]),
      child: Column(
        children: [
          animatedStatusIcon(),
          // Icon(
          //   Icons.check_circle,
          //   color: Colors.green,
          //   size: 48,
          // ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Order Confirmed',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Your order has been confirmed and is being prepared',
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget timeEstimate() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, color: Colors.deepOrange),
          const SizedBox(width: 16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estimated Time',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                '15-20 minutes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  Widget animatedStatusIcon() {
    switch (currentStatus) {
      case CustomerOrderStatus.Confirmed:
        return confirmedAnimation();

      // case CustomerOrderStatus.Preparing:
      //   return 'something';
      case CustomerOrderStatus.Preparing:
        return preparingAnimation();

      case CustomerOrderStatus.ReadyForPickUp:
        return readyAnimation();

      case CustomerOrderStatus.Completed:
        return completedAnimation();
      default:
        return const Icon(Icons.check_circle_outline, color: Colors.deepOrange, size: 64);
    }
  }

  Widget confirmedAnimation() {
    return ScaleTransition(
      scale: Tween<double>(begin: 1, end: 1.2).animate(pulseController),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepOrange.withAlpha((0.1 * 255).round()),
        ),
        child: const Icon(
          Icons.check_circle_outline,
          color: Colors.deepOrange,
          size: 64,
        ),
      ),
    );
  }

  Widget preparingAnimation() {
    return RotationTransition(
      turns: progressController,
      child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepOrange.withAlpha((0.1 * 255).round()),
          ),
          child: const Icon(
            Icons.restaurant,
            size: 64,
            color: Colors.deepOrange,
          )),
    );
  }

  Widget readyAnimation() {
    return AnimatedBuilder(
      animation: progressController,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.withAlpha((0.1 * 255).round()),
              border: Border.all(
                color: Colors.green.withAlpha((progressController.value * 255).round()),
                width: 3,
              )),
          child: const Icon(
            Icons.shopping_bag,
            size: 64,
            color: Colors.green,
          ),
        );
      },
    );
  }

  Widget completedAnimation() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green.withAlpha((0.1 * 255).round()),
      ),
      child: const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 64,
      ),
    );
  }
}
