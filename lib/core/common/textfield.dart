import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mechine_test_nasih/core/theme/color.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool showCountryCode;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool isMandatory;
  final bool isLabelEnabled;
  final String? label;
  final bool isMultiline;
  final bool needBorder;
  final bool isReadOnly;
  final TextAlign textAlign;
  final TextStyle? style;
  final List<TextInputFormatter>? inputFormatters;
  final InputDecoration? decoration;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final bool showTooltip;
  final String? tooltipMessage;

  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.showCountryCode = false,
    this.hintText,
    this.keyboardType,
    this.isMandatory = false,
    this.isLabelEnabled = false,
    this.label,
    this.isMultiline = false,
    this.needBorder = false,
    this.isReadOnly = false,
    this.textAlign = TextAlign.start,
    this.style,
    this.inputFormatters,
    this.decoration,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.autovalidateMode,
    this.showTooltip = false,
    this.tooltipMessage,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;
  bool _showTooltipDialog = false;
  final GlobalKey _tooltipKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeTooltipSafely();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textField = widget.showCountryCode
        ? _buildPhoneField()
        : _buildNormalField();

    if (widget.isLabelEnabled && widget.label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLabel(),
          const SizedBox(height: 5),
          textField,
          if (_errorText != null) _buildErrorText(_errorText),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textField,
        if (_errorText != null) _buildErrorText(_errorText),
      ],
    );
  }

  Widget _buildPhoneField() {
    final normalBorderColor = widget.needBorder
        ? const Color(0xFFE5E5E5)
        : Colors.transparent;

    final borderColor = _errorText != null ? Colors.red : normalBorderColor;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: const Text(
              '+91',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              readOnly: widget.isReadOnly,
              cursorColor: AppColors.primary,
              keyboardType: TextInputType.phone,
              textAlign: widget.textAlign,
              style: widget.style,
              validator: (value) {
                final error = widget.validator?.call(value);
                if (mounted) {
                  setState(() {
                    _errorText = error;
                  });
                }
                return error;
              },
              autovalidateMode: widget.autovalidateMode,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorStyle: const TextStyle(height: 0, fontSize: 0),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
              ),
              inputFormatters:
                  widget.inputFormatters ??
                  [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
              onChanged: widget.onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalField() {
    final normalBorderColor = widget.needBorder
        ? const Color(0xFFE5E5E5)
        : Colors.transparent;

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      readOnly: widget.isReadOnly,
      cursorColor: AppColors.primary,
      keyboardType: widget.isMultiline
          ? TextInputType.multiline
          : widget.keyboardType,
      minLines: widget.isMultiline ? 3 : 1,
      maxLines: widget.isMultiline ? 5 : 1,
      textAlign: widget.textAlign,
      style:
          widget.style?.copyWith(
            color: widget.isReadOnly ? Colors.grey[600] : null,
          ) ??
          TextStyle(
            color: widget.isReadOnly ? Colors.grey[600] : Colors.black87,
          ),
      inputFormatters: widget.inputFormatters,
      validator: (value) {
        final error = widget.validator?.call(value);
        if (mounted) {
          setState(() {
            _errorText = error;
          });
        }
        return error;
      },
      autovalidateMode: widget.autovalidateMode,
      decoration:
          widget.decoration ??
          InputDecoration(
            filled: true,
            fillColor: widget.isReadOnly ? Colors.grey[100] : AppColors.white,
            hintText: widget.hintText,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            suffixIcon: widget.isReadOnly
                ? Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.lock_outline,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: widget.isReadOnly
                    ? Colors.grey[300]!
                    : normalBorderColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: widget.isReadOnly
                    ? Colors.grey[300]!
                    : AppColors.primary,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
          ),
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
    );
  }

  Widget _buildErrorText(String? errorText) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 4),
      child: Text(
        errorText ?? "",
        style: const TextStyle(fontSize: 12, color: Colors.red),
      ),
    );
  }

  Widget _buildLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              widget.label!,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.isMandatory)
              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  '*',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        if (widget.showTooltip && widget.tooltipMessage != null)
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: GestureDetector(
              key: _tooltipKey,
              onTap: _toggleTooltip,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.info_outline,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _toggleTooltip() {
    if (_showTooltipDialog) {
      _removeTooltip();
    } else {
      _showTooltipPopup();
    }
  }

  void _removeTooltipSafely() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _showTooltipDialog = false;
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _showTooltipDialog = false;
      });
    }
  }

  void _showTooltipPopup() {
    final RenderBox? renderBox =
        _tooltipKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final overlay = Overlay.of(context);
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (mounted) {
      setState(() {
        _showTooltipDialog = true;
      });
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _removeTooltip,
        behavior: HitTestBehavior.translucent,
        child: Stack(
          children: [
            Container(color: Colors.transparent),
            _TooltipPopup(
              iconPosition: position,
              iconSize: size,
              message: widget.tooltipMessage!,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
          ],
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }
}

class _TooltipPopup extends StatelessWidget {
  final Offset iconPosition;
  final Size iconSize;
  final String message;
  final double screenWidth;
  final double screenHeight;

  const _TooltipPopup({
    required this.iconPosition,
    required this.iconSize,
    required this.message,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    const tooltipMaxWidth = 250.0;
    const tooltipMinWidth = 120.0;
    const tooltipPadding = 16.0;
    const arrowHeight = 6.0;
    const arrowWidth = 12.0;

    // Calculate text size to determine actual tooltip width
    final textPainter = TextPainter(
      text: TextSpan(
        text: message,
        style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: tooltipMaxWidth - 28); // Account for padding

    // Calculate actual tooltip width based on content
    final tooltipWidth = (textPainter.width + 28).clamp(
      tooltipMinWidth,
      tooltipMaxWidth,
    );
    final tooltipHeight = textPainter.height + 20; // Add padding

    final iconCenterX = iconPosition.dx + (iconSize.width / 2);
    final iconBottom = iconPosition.dy + iconSize.height;
    final iconTop = iconPosition.dy;

    // Calculate tooltip left position
    double tooltipLeft = iconCenterX - (tooltipWidth / 2);

    // Ensure tooltip stays within screen bounds
    if (tooltipLeft < tooltipPadding) {
      tooltipLeft = tooltipPadding;
    } else if (tooltipLeft + tooltipWidth > screenWidth - tooltipPadding) {
      tooltipLeft = screenWidth - tooltipWidth - tooltipPadding;
    }

    // Calculate arrow position relative to icon center
    double arrowLeft = iconCenterX - (arrowWidth / 2);

    // Constrain arrow to stay within tooltip bounds
    final tooltipRight = tooltipLeft + tooltipWidth;
    if (arrowLeft < tooltipLeft + 10) {
      arrowLeft = tooltipLeft + 10;
    } else if (arrowLeft + arrowWidth > tooltipRight - 10) {
      arrowLeft = tooltipRight - arrowWidth - 10;
    }

    // Determine if tooltip should show above or below
    final spaceBelow = screenHeight - iconBottom;
    final spaceAbove = iconTop;
    final showAbove =
        spaceBelow < tooltipHeight + arrowHeight + 20 &&
        spaceAbove > tooltipHeight + arrowHeight + 20;

    // Calculate tooltip top position
    final tooltipTop = showAbove
        ? iconTop - tooltipHeight - arrowHeight - 4
        : iconBottom + arrowHeight + 4;

    // Calculate arrow top position
    final arrowTop = showAbove ? iconTop - arrowHeight - 4 : iconBottom + 4;

    return Stack(
      children: [
        // Tooltip box
        Positioned(
          left: tooltipLeft,
          top: tooltipTop,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: tooltipWidth,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF2D3748),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),

        // Arrow
        Positioned(
          left: arrowLeft,
          top: arrowTop,
          child: CustomPaint(
            size: const Size(arrowWidth, arrowHeight),
            painter: _TooltipArrowPainter(pointUp: showAbove),
          ),
        ),
      ],
    );
  }
}

class _TooltipArrowPainter extends CustomPainter {
  final bool pointUp;

  _TooltipArrowPainter({this.pointUp = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF2D3748)
      ..style = PaintingStyle.fill;

    final path = Path();

    if (pointUp) {
      // Arrow pointing up (tooltip below icon)
      path.moveTo(size.width / 2, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      // Arrow pointing down (tooltip above icon)
      path.moveTo(size.width / 2, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
