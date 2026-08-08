import 'package:flutter/material.dart';

class MatchingPairsWidget extends StatefulWidget {
  final Map<String, String> pairs;
  final ValueChanged<bool> onCompleted;

  const MatchingPairsWidget({
    super.key,
    required this.pairs,
    required this.onCompleted,
  });

  @override
  State<MatchingPairsWidget> createState() => _MatchingPairsWidgetState();
}

class _MatchingPairsWidgetState extends State<MatchingPairsWidget> {
  late List<String> _leftItems;
  late List<String> _rightItems;

  String? _selectedLeft;
  String? _selectedRight;

  final Set<String> _matchedKeys = {};

  @override
  void initState() {
    super.initState();
    _leftItems = widget.pairs.keys.toList()..shuffle();
    _rightItems = widget.pairs.values.toList()..shuffle();
  }

  void _onLeftTap(String left) {
    if (_matchedKeys.contains(left)) return;
    setState(() {
      _selectedLeft = left;
      _checkMatch();
    });
  }

  void _onRightTap(String right) {
    setState(() {
      _selectedRight = right;
      _checkMatch();
    });
  }

  void _checkMatch() {
    if (_selectedLeft != null && _selectedRight != null) {
      final targetRight = widget.pairs[_selectedLeft];
      if (targetRight == _selectedRight) {
        _matchedKeys.add(_selectedLeft!);
        _selectedLeft = null;
        _selectedRight = null;

        if (_matchedKeys.length == widget.pairs.length) {
          widget.onCompleted(true);
        }
      } else {
        // Wrong match delay reset
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            setState(() {
              _selectedLeft = null;
              _selectedRight = null;
            });
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Tap matching pairs:',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Row(
            children: [
              // Left Column
              Expanded(
                child: ListView.builder(
                  itemCount: _leftItems.length,
                  itemBuilder: (context, index) {
                    final item = _leftItems[index];
                    final isMatched = _matchedKeys.contains(item);
                    final isSelected = _selectedLeft == item;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: OutlinedButton(
                        onPressed: isMatched ? null : () => _onLeftTap(item),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: isMatched
                              ? Colors.green.withValues(alpha: 0.15)
                              : isSelected
                                  ? theme.colorScheme.primaryContainer
                                  : null,
                          side: BorderSide(
                            color: isMatched
                                ? Colors.green
                                : isSelected
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outline,
                            width: isSelected ? 2 : 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isMatched
                                ? Colors.green
                                : isSelected
                                    ? theme.colorScheme.onPrimaryContainer
                                    : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Right Column
              Expanded(
                child: ListView.builder(
                  itemCount: _rightItems.length,
                  itemBuilder: (context, index) {
                    final item = _rightItems[index];
                    final isMatched = widget.pairs.entries.any(
                      (e) => _matchedKeys.contains(e.key) && e.value == item,
                    );
                    final isSelected = _selectedRight == item;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: OutlinedButton(
                        onPressed: isMatched ? null : () => _onRightTap(item),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: isMatched
                              ? Colors.green.withValues(alpha: 0.15)
                              : isSelected
                                  ? theme.colorScheme.secondaryContainer
                                  : null,
                          side: BorderSide(
                            color: isMatched
                                ? Colors.green
                                : isSelected
                                    ? theme.colorScheme.secondary
                                    : theme.colorScheme.outline,
                            width: isSelected ? 2 : 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isMatched
                                ? Colors.green
                                : isSelected
                                    ? theme.colorScheme.onSecondaryContainer
                                    : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
