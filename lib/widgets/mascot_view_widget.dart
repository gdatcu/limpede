import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/mascot_character.dart';
import '../providers/course_provider.dart';
import '../providers/mascot_state_controller.dart';

class MascotViewWidget extends ConsumerStatefulWidget {
  final double size;
  final bool showSpeechBubble;
  final bool enableTapInteraction;
  final bool enableMouseTracking;
  final Alignment bubbleAlignment;
  final VoidCallback? onCustomTap;

  const MascotViewWidget({
    super.key,
    this.size = 110,
    this.showSpeechBubble = true,
    this.enableTapInteraction = true,
    this.enableMouseTracking = true,
    this.bubbleAlignment = Alignment.topCenter,
    this.onCustomTap,
  });

  @override
  ConsumerState<MascotViewWidget> createState() => _MascotViewWidgetState();
}

class _MascotViewWidgetState extends ConsumerState<MascotViewWidget>
    with TickerProviderStateMixin {
  late AnimationController _idleController;
  late AnimationController _blinkController;
  late AnimationController _jumpController;
  late AnimationController _dizzyController;

  double _squishX = 1.0;
  double _squishY = 1.0;
  bool _isBlinking = false;

  @override
  void initState() {
    super.initState();

    // 1. Idle breathing float
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    // 2. Periodic Blink
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _blinkController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _isBlinking = false);
        _blinkController.reverse();
      }
    });
    _scheduleNextBlink();

    // 3. Jump celebration
    _jumpController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // 4. Dizzy spin
    _dizzyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  void _scheduleNextBlink() {
    final nextMs = 2500 + math.Random().nextInt(3000);
    Future.delayed(Duration(milliseconds: nextMs), () {
      if (mounted) {
        setState(() => _isBlinking = true);
        _blinkController.forward();
        _scheduleNextBlink();
      }
    });
  }

  @override
  void dispose() {
    _idleController.dispose();
    _blinkController.dispose();
    _jumpController.dispose();
    _dizzyController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (!widget.enableTapInteraction) {
      widget.onCustomTap?.call();
      return;
    }

    // Spring squish animation
    setState(() {
      _squishX = 1.25;
      _squishY = 0.8;
    });
    Future.delayed(const Duration(milliseconds: 160), () {
      if (mounted) {
        setState(() {
          _squishX = 0.9;
          _squishY = 1.12;
        });
        Future.delayed(const Duration(milliseconds: 140), () {
          if (mounted) {
            setState(() {
              _squishX = 1.0;
              _squishY = 1.0;
            });
          }
        });
      }
    });

    _jumpController.forward(from: 0.0);

    final courseState = ref.read(courseStateNotifierProvider);
    ref.read(mascotStateNotifierProvider.notifier).onTapMascot(
          nativeLanguage: courseState.nativeLanguage,
        );

    widget.onCustomTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final mascotState = ref.watch(mascotStateNotifierProvider);
    final character = mascotState.character;
    final mood = mascotState.mood;

    if (mood == MascotMood.celebrating || mood == MascotMood.streakFire) {
      if (!_jumpController.isAnimating && _jumpController.value == 0) {
        _jumpController.forward(from: 0.0);
      }
    }

    if (mood == MascotMood.dizzy) {
      if (!_dizzyController.isAnimating) {
        _dizzyController.repeat();
      }
    } else {
      if (_dizzyController.isAnimating) {
        _dizzyController.stop();
        _dizzyController.reset();
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: widget.enableMouseTracking
              ? (event) {
                  final renderBox = context.findRenderObject() as RenderBox?;
                  if (renderBox != null) {
                    final local = renderBox.globalToLocal(event.position);
                    final center = Offset(renderBox.size.width / 2, renderBox.size.height / 2);
                    final lookX = ((local.dx - center.dx) / (renderBox.size.width / 2)).clamp(-1.0, 1.0);
                    final lookY = ((local.dy - center.dy) / (renderBox.size.height / 2)).clamp(-1.0, 1.0);
                    ref.read(mascotStateNotifierProvider.notifier).setGaze(Offset(lookX, lookY));
                  }
                }
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Speech bubble
              if (widget.showSpeechBubble && mascotState.speechQuote != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _buildSpeechBubble(context, mascotState.speechQuote!, character),
                ),

              // Animated Mascot
              GestureDetector(
                onTap: _handleTap,
                child: AnimatedBuilder(
                  animation: Listenable.merge([
                    _idleController,
                    _jumpController,
                    _dizzyController,
                  ]),
                  builder: (context, child) {
                    // Floating bounce calculation
                    final idleFloat = math.sin(_idleController.value * math.pi * 2) * 4.0;
                    final jumpOffset = -math.sin(_jumpController.value * math.pi) * 16.0;
                    final totalY = idleFloat + jumpOffset;
                    final spinAngle = mood == MascotMood.dizzy
                        ? _dizzyController.value * math.pi * 4
                        : 0.0;

                    return Transform.translate(
                      offset: Offset(0, totalY),
                      child: Transform.rotate(
                        angle: spinAngle,
                        child: Transform.scale(
                          scaleX: _squishX,
                          scaleY: _squishY,
                          child: SizedBox(
                            width: widget.size,
                            height: widget.size,
                            child: CustomPaint(
                              painter: MascotPainter(
                                character: character,
                                mood: mood,
                                gazeTarget: mascotState.gazeTarget,
                                isBlinking: _isBlinking,
                                animationProgress: _idleController.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSpeechBubble(
      BuildContext context, String text, MascotCharacter character) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(maxWidth: 240),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: character.primaryColor.withValues(alpha: 0.7),
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: character.glowColor.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
          height: 1.25,
        ),
      ),
    );
  }
}

class MascotPainter extends CustomPainter {
  final MascotCharacter character;
  final MascotMood mood;
  final Offset gazeTarget;
  final bool isBlinking;
  final double animationProgress;

  MascotPainter({
    required this.character,
    required this.mood,
    required this.gazeTarget,
    required this.isBlinking,
    required this.animationProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + size.height * 0.05);
    final radius = size.width * 0.38;

    // 1. Draw Particle Glow / Aura
    _drawAura(canvas, center, radius);

    // 2. Draw Head Features (Antenna, Horns, Leaves)
    _drawHeadFeature(canvas, center, radius);

    // 3. Draw Fluid Body Drop
    _drawBody(canvas, center, radius);

    // 4. Draw Face (Eyes, Pupils, Mouth, Cheeks)
    _drawFace(canvas, center, radius);
  }

  void _drawAura(Canvas canvas, Offset center, double radius) {
    if (mood == MascotMood.streakFire || mood == MascotMood.celebrating) {
      final auraPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            character.sparkColor.withValues(alpha: 0.55),
            character.primaryColor.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius * 1.55));

      canvas.drawCircle(center, radius * 1.55, auraPaint);

      // Draw floating spark stars
      const sparkCount = 4;
      for (int i = 0; i < sparkCount; i++) {
        final angle = (animationProgress * math.pi * 2) + (i * math.pi * 2 / sparkCount);
        final sparkDist = radius * 1.22;
        final sx = center.dx + math.cos(angle) * sparkDist;
        final sy = center.dy + math.sin(angle) * sparkDist * 0.7;

        final sparkPaint = Paint()
          ..color = character.sparkColor
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(sx, sy), 3.5, sparkPaint);
      }
    }
  }

  void _drawHeadFeature(Canvas canvas, Offset center, double radius) {
    final topPoint = Offset(center.dx, center.dy - radius * 0.95);

    switch (character.headFeature) {
      case MascotHeadFeature.lightningAntenna:
        // Pede: Electric lightning antenna with golden spark ⚡
        final path = Path();
        path.moveTo(topPoint.dx - 3, topPoint.dy + 4);
        path.lineTo(topPoint.dx + 4, topPoint.dy - 12);
        path.lineTo(topPoint.dx - 2, topPoint.dy - 13);
        path.lineTo(topPoint.dx + 8, topPoint.dy - 28);
        path.lineTo(topPoint.dx + 1, topPoint.dy - 18);
        path.lineTo(topPoint.dx + 6, topPoint.dy - 17);
        path.close();

        final boltPaint = Paint()
          ..shader = LinearGradient(
            colors: [character.sparkColor, character.primaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromCircle(center: topPoint, radius: 25));

        canvas.drawPath(path, boltPaint);

        // Glowing tip spark
        canvas.drawCircle(
          Offset(topPoint.dx + 8, topPoint.dy - 28),
          4.0,
          Paint()..color = character.sparkColor,
        );
        break;

      case MascotHeadFeature.crescentCrown:
        // Nyx: Amethyst crescent horns 🌙
        final leftHorn = Path()
          ..moveTo(center.dx - radius * 0.45, topPoint.dy + 8)
          ..quadraticBezierTo(
            center.dx - radius * 0.9,
            topPoint.dy - 22,
            center.dx - radius * 0.65,
            topPoint.dy - 32,
          )
          ..quadraticBezierTo(
            center.dx - radius * 0.35,
            topPoint.dy - 12,
            center.dx - radius * 0.25,
            topPoint.dy + 8,
          );

        final rightHorn = Path()
          ..moveTo(center.dx + radius * 0.45, topPoint.dy + 8)
          ..quadraticBezierTo(
            center.dx + radius * 0.9,
            topPoint.dy - 22,
            center.dx + radius * 0.65,
            topPoint.dy - 32,
          )
          ..quadraticBezierTo(
            center.dx + radius * 0.35,
            topPoint.dy - 12,
            center.dx + radius * 0.25,
            topPoint.dy + 8,
          );

        final hornPaint = Paint()
          ..shader = LinearGradient(
            colors: [character.sparkColor, character.primaryColor],
          ).createShader(Rect.fromCircle(center: topPoint, radius: 30));

        canvas.drawPath(leftHorn, hornPaint);
        canvas.drawPath(rightHorn, hornPaint);
        break;

      case MascotHeadFeature.flameSpikes:
        // Volta: Triple flame spikes 🔥
        final flamePath = Path()
          ..moveTo(center.dx - 18, topPoint.dy + 6)
          ..lineTo(center.dx - 22, topPoint.dy - 16)
          ..lineTo(center.dx - 8, topPoint.dy - 4)
          ..lineTo(center.dx, topPoint.dy - 30) // Center flame
          ..lineTo(center.dx + 8, topPoint.dy - 4)
          ..lineTo(center.dx + 22, topPoint.dy - 16)
          ..lineTo(center.dx + 18, topPoint.dy + 6)
          ..close();

        final flamePaint = Paint()
          ..shader = LinearGradient(
            colors: [character.sparkColor, character.primaryColor, character.secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromCircle(center: topPoint, radius: 32));

        canvas.drawPath(flamePath, flamePaint);
        break;

      case MascotHeadFeature.zenLeaf:
        // Kora: Zen jade leaf 🌿
        final leafPath = Path()
          ..moveTo(topPoint.dx, topPoint.dy + 6)
          ..quadraticBezierTo(
            topPoint.dx + 20,
            topPoint.dy - 16,
            topPoint.dx + 12,
            topPoint.dy - 30,
          )
          ..quadraticBezierTo(
            topPoint.dx - 14,
            topPoint.dy - 18,
            topPoint.dx,
            topPoint.dy + 6,
          );

        final leafPaint = Paint()
          ..shader = LinearGradient(
            colors: [character.sparkColor, character.primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromCircle(center: topPoint, radius: 25));

        canvas.drawPath(leafPath, leafPaint);
        break;

      case MascotHeadFeature.bubbleBlush:
        // Boba: Floating top bubble 🫧
        canvas.drawCircle(
          Offset(topPoint.dx + 8, topPoint.dy - 18),
          8.0,
          Paint()
            ..color = character.sparkColor.withValues(alpha: 0.8)
            ..style = PaintingStyle.fill,
        );
        canvas.drawCircle(
          Offset(topPoint.dx - 12, topPoint.dy - 8),
          5.0,
          Paint()
            ..color = character.glowColor.withValues(alpha: 0.8)
            ..style = PaintingStyle.fill,
        );
        break;
    }
  }

  void _drawBody(Canvas canvas, Offset center, double radius) {
    // Teardrop / Crystal Droplet Geometry
    final bodyPath = Path();
    bodyPath.moveTo(center.dx, center.dy - radius * 0.92);
    // Right curve down
    bodyPath.cubicTo(
      center.dx + radius * 0.95,
      center.dy - radius * 0.35,
      center.dx + radius * 1.05,
      center.dy + radius * 0.65,
      center.dx,
      center.dy + radius * 0.98,
    );
    // Left curve up
    bodyPath.cubicTo(
      center.dx - radius * 1.05,
      center.dy + radius * 0.65,
      center.dx - radius * 0.95,
      center.dy - radius * 0.35,
      center.dx,
      center.dy - radius * 0.92,
    );
    bodyPath.close();

    // Body Gradient
    final bodyPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          character.primaryColor,
          character.secondaryColor,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawPath(bodyPath, bodyPaint);

    // Crystal Gloss Highlight
    final highlightPath = Path()
      ..moveTo(center.dx - radius * 0.55, center.dy - radius * 0.45)
      ..quadraticBezierTo(
        center.dx - radius * 0.3,
        center.dy - radius * 0.75,
        center.dx,
        center.dy - radius * 0.75,
      )
      ..quadraticBezierTo(
        center.dx - radius * 0.2,
        center.dy - radius * 0.5,
        center.dx - radius * 0.55,
        center.dy - radius * 0.45,
      );

    canvas.drawPath(
      highlightPath,
      Paint()..color = Colors.white.withValues(alpha: 0.45),
    );
  }

  void _drawFace(Canvas canvas, Offset center, double radius) {
    final eyeSpacing = radius * 0.38;
    final eyeY = center.dy - radius * 0.05;
    final eyeRadius = radius * 0.22;

    final leftEyeCenter = Offset(center.dx - eyeSpacing, eyeY);
    final rightEyeCenter = Offset(center.dx + eyeSpacing, eyeY);

    // Cheek Blushes
    final blushPaint = Paint()
      ..color = character.sparkColor.withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx - eyeSpacing * 1.4, eyeY + eyeRadius * 1.2),
        width: eyeRadius * 1.1,
        height: eyeRadius * 0.6,
      ),
      blushPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx + eyeSpacing * 1.4, eyeY + eyeRadius * 1.2),
        width: eyeRadius * 1.1,
        height: eyeRadius * 0.6,
      ),
      blushPaint,
    );

    // 1. Draw Eyes
    if (isBlinking || mood == MascotMood.sleeping) {
      // Eyelid line
      final blinkPaint = Paint()
        ..color = character.eyeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(leftEyeCenter.dx - eyeRadius, leftEyeCenter.dy),
        Offset(leftEyeCenter.dx + eyeRadius, leftEyeCenter.dy),
        blinkPaint,
      );
      canvas.drawLine(
        Offset(rightEyeCenter.dx - eyeRadius, rightEyeCenter.dy),
        Offset(rightEyeCenter.dx + eyeRadius, rightEyeCenter.dy),
        blinkPaint,
      );
    } else if (mood == MascotMood.celebrating || mood == MascotMood.streakFire) {
      // Happy Crescent Eyes (^ ^)
      final happyPaint = Paint()
        ..color = character.eyeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round;

      final leftHappy = Path()
        ..moveTo(leftEyeCenter.dx - eyeRadius * 0.9, leftEyeCenter.dy + 2)
        ..quadraticBezierTo(
          leftEyeCenter.dx,
          leftEyeCenter.dy - eyeRadius * 1.1,
          leftEyeCenter.dx + eyeRadius * 0.9,
          leftEyeCenter.dy + 2,
        );
      final rightHappy = Path()
        ..moveTo(rightEyeCenter.dx - eyeRadius * 0.9, rightEyeCenter.dy + 2)
        ..quadraticBezierTo(
          rightEyeCenter.dx,
          rightEyeCenter.dy - eyeRadius * 1.1,
          rightEyeCenter.dx + eyeRadius * 0.9,
          rightEyeCenter.dy + 2,
        );

      canvas.drawPath(leftHappy, happyPaint);
      canvas.drawPath(rightHappy, happyPaint);
    } else if (mood == MascotMood.dizzy) {
      // Spiral Dizzy Eyes (@ @)
      final spiralPaint = Paint()
        ..color = character.eyeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round;

      _drawSpiral(canvas, leftEyeCenter, eyeRadius, spiralPaint);
      _drawSpiral(canvas, rightEyeCenter, eyeRadius, spiralPaint);
    } else {
      // Standard Expressive Eyes with Gaze Tracking
      final scleraPaint = Paint()..color = Colors.white;
      canvas.drawCircle(leftEyeCenter, eyeRadius, scleraPaint);
      canvas.drawCircle(rightEyeCenter, eyeRadius, scleraPaint);

      // Pupil offset based on gaze (-1.0 to 1.0)
      final maxGazeOffset = eyeRadius * 0.45;
      final pupilOffset = Offset(
        gazeTarget.dx * maxGazeOffset,
        gazeTarget.dy * maxGazeOffset,
      );

      final pupilRadius = eyeRadius * 0.62;
      final pupilPaint = Paint()..color = character.eyeColor;

      canvas.drawCircle(leftEyeCenter + pupilOffset, pupilRadius, pupilPaint);
      canvas.drawCircle(rightEyeCenter + pupilOffset, pupilRadius, pupilPaint);

      // Catchlight Sparkles
      final sparklePaint = Paint()..color = Colors.white;
      canvas.drawCircle(
        leftEyeCenter + pupilOffset - const Offset(2.5, 2.5),
        pupilRadius * 0.35,
        sparklePaint,
      );
      canvas.drawCircle(
        rightEyeCenter + pupilOffset - const Offset(2.5, 2.5),
        pupilRadius * 0.35,
        sparklePaint,
      );

      // Nyx Half-lidded eyelids
      if (character.id == MascotId.nyx) {
        final lidPaint = Paint()..color = character.primaryColor;
        canvas.drawArc(
          Rect.fromCircle(center: leftEyeCenter, radius: eyeRadius + 1),
          math.pi,
          math.pi,
          true,
          lidPaint,
        );
        canvas.drawArc(
          Rect.fromCircle(center: rightEyeCenter, radius: eyeRadius + 1),
          math.pi,
          math.pi,
          true,
          lidPaint,
        );
      }
    }

    // 2. Draw Mouth
    final mouthY = eyeY + eyeRadius * 1.5;
    final mouthCenter = Offset(center.dx, mouthY);

    final mouthPaint = Paint()
      ..color = character.eyeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    if (mood == MascotMood.celebrating || mood == MascotMood.streakFire) {
      // Wide Happy Smile
      final mouthPath = Path()
        ..moveTo(mouthCenter.dx - radius * 0.22, mouthCenter.dy)
        ..quadraticBezierTo(
          mouthCenter.dx,
          mouthCenter.dy + radius * 0.32,
          mouthCenter.dx + radius * 0.22,
          mouthCenter.dy,
        )
        ..close();

      canvas.drawPath(mouthPath, Paint()..color = character.eyeColor);
      // Tongue
      canvas.drawCircle(
        Offset(mouthCenter.dx, mouthCenter.dy + radius * 0.16),
        radius * 0.08,
        Paint()..color = const Color(0xFFFF5252),
      );
    } else if (mood == MascotMood.sympathetic) {
      // Soft gentle wavy mouth ~
      final softPath = Path()
        ..moveTo(mouthCenter.dx - radius * 0.15, mouthCenter.dy + 3)
        ..quadraticBezierTo(
          mouthCenter.dx,
          mouthCenter.dy - 3,
          mouthCenter.dx + radius * 0.15,
          mouthCenter.dy + 3,
        );
      canvas.drawPath(softPath, mouthPaint);
    } else if (mood == MascotMood.thinking || mood == MascotMood.anticipating) {
      // Curious "O" mouth
      canvas.drawOval(
        Rect.fromCenter(center: mouthCenter, width: 8, height: 11),
        Paint()..color = character.eyeColor,
      );
    } else {
      // Default cute smile :)
      final smilePath = Path()
        ..moveTo(mouthCenter.dx - radius * 0.16, mouthCenter.dy)
        ..quadraticBezierTo(
          mouthCenter.dx,
          mouthCenter.dy + radius * 0.16,
          mouthCenter.dx + radius * 0.16,
          mouthCenter.dy,
        );
      canvas.drawPath(smilePath, mouthPaint);
    }
  }

  void _drawSpiral(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (double theta = 0; theta < math.pi * 4; theta += 0.2) {
      final r = (theta / (math.pi * 4)) * radius * 0.85;
      final x = center.dx + r * math.cos(theta);
      final y = center.dy + r * math.sin(theta);
      if (theta == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant MascotPainter oldDelegate) {
    return oldDelegate.mood != mood ||
        oldDelegate.gazeTarget != gazeTarget ||
        oldDelegate.isBlinking != isBlinking ||
        oldDelegate.animationProgress != animationProgress ||
        oldDelegate.character.id != character.id;
  }
}
