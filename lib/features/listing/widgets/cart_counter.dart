import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({
    required this.maxValue,
    super.key,
    this.onChanged,
    this.minValue,
    this.initialValue,
  });
  final int maxValue;
  final int? minValue;
  final ValueChanged<int>? onChanged;
  final int? initialValue;

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int _count = 1;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue ?? widget.minValue ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Decrement button
        IconButton.outlined(
          icon: const Icon(Icons.remove),
          onPressed:
              _count == (widget.minValue ?? 1)
                  ? null
                  : () {
                    setState(() {
                      if (_count > (widget.minValue ?? 1)) {
                        _count--;
                        widget.onChanged?.call(_count);
                      }
                    });
                  },
        ),

        // Counter display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('$_count', style: const TextStyle(fontSize: 18)),
        ),

        // Increment button
        IconButton.outlined(
          icon: const Icon(Icons.add),
          onPressed:
              _count == widget.maxValue
                  ? null
                  : () {
                    setState(() {
                      if (_count < widget.maxValue) {
                        _count++;
                        widget.onChanged?.call(_count);
                      }
                    });
                  },
        ),
      ],
    );
  }
}
