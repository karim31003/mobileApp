// Full corrected code for accurate point rendering on image
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';

class Area extends StatelessWidget {
  const Area({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoomAreaScreen();
  }
}

class RoomAreaScreen extends StatefulWidget {
  const RoomAreaScreen({super.key});

  @override
  _RoomAreaScreenState createState() => _RoomAreaScreenState();
}

class _RoomAreaScreenState extends State<RoomAreaScreen> {
  File? _image;
  List<Offset> _points = [];
  double _pixelToCmRatio = 0.0264;
  final TextEditingController _scaleController = TextEditingController();
  bool _isSettingScale = true;

  double? _originalImageWidth;
  double? _originalImageHeight;

  Offset _imageOffset = Offset.zero;
  Size? _imageDisplaySize;

  // Add this field to the state
  String _lengthUnit = 'cm';

  Future<void> _takePhoto() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final image = File(pickedFile.path);
      final decoded = await decodeImageFromList(image.readAsBytesSync());
      setState(() {
        _image = image;
        _originalImageWidth = decoded.width.toDouble();
        _originalImageHeight = decoded.height.toDouble();
        _points.clear();
        _isSettingScale = true;
        _imageDisplaySize = null;
      });
    }
  }

  // Add this method to pick from gallery
  Future<void> _pickFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final image = File(pickedFile.path);
      final decoded = await decodeImageFromList(image.readAsBytesSync());
      setState(() {
        _image = image;
        _originalImageWidth = decoded.width.toDouble();
        _originalImageHeight = decoded.height.toDouble();
        _points.clear();
        _isSettingScale = true;
        _imageDisplaySize = null;
      });
    }
  }

  void _handleTap(TapDownDetails details, Size containerSize) {
    if (_image == null || _originalImageWidth == null || _originalImageHeight == null) return;

    final imageSize = Size(_originalImageWidth!, _originalImageHeight!);
    final scale = _calculateImageScale(containerSize, imageSize.width, imageSize.height);
    final offset = _calculateImageOffset(containerSize, imageSize.width * scale, imageSize.height * scale);

    setState(() {
      _imageDisplaySize = Size(imageSize.width * scale, imageSize.height * scale);
      _imageOffset = offset;

      final local = details.localPosition;
      final dx = (local.dx - offset.dx) / scale;
      final dy = (local.dy - offset.dy) / scale;

      if (dx >= 0 && dy >= 0 && dx <= imageSize.width && dy <= imageSize.height) {
        final tappedPoint = Offset(dx, dy);
        if (_isSettingScale && _points.length < 2) {
          _points.add(tappedPoint);
        } else if (!_isSettingScale && _points.length < 4) {
          _points.add(tappedPoint);
        }
      }
    });
  }

  double _calculateImageScale(Size container, double width, double height) {
    final widthRatio = container.width / width;
    final heightRatio = container.height / height;
    return min(widthRatio, heightRatio);
  }

  Offset _calculateImageOffset(Size container, double scaledWidth, double scaledHeight) {
    return Offset(
      (container.width - scaledWidth) / 2,
      (container.height - scaledHeight) / 2,
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  double _calculateArea(List<Offset> points) {
    if (points.length < 3) return 0.0;
    double area = 0;
    for (int i = 0; i < points.length; i++) {
      final p1 = points[i];
      final p2 = points[(i + 1) % points.length];
      area += p1.dx * p2.dy - p1.dy * p2.dx;
    }
    return area.abs() / 2;
  }

  void _setScaleReference() {
    final input = double.tryParse(_scaleController.text);
    if (input == null || input <= 0) {
      _showSnackBar('Enter valid length');
      return;
    }
    double inputCm = input;
    if (_lengthUnit == 'm') {
      inputCm = input * 100;
    }
    if (_points.length == 2) {
      final pxDistance = (_points[0] - _points[1]).distance;
      _pixelToCmRatio = inputCm / pxDistance;
      _points.clear();
      setState(() => _isSettingScale = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final area = _points.length >= 3 ? _calculateArea(_points) * pow(_pixelToCmRatio, 2) : null;
    return Scaffold(
      appBar: AppBar(title: const Text('Room Area Estimator',style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent,foregroundColor: Color(0xFFffffff),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GestureDetector(
                    onTapDown: (d) => _handleTap(d, constraints.biggest),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: _image != null ? Image.file(_image!, fit: BoxFit.contain) :
                            const Text("Begin by taking a photo. Then, scale the image by selecting two points with a known distance between them. Next, point to the bottom left side, followed by the top left. Continue by indicating the top right side, and finally, the bottom right."),
                          ),
                        ),
                        if (_image != null && _imageDisplaySize != null)
                          CustomPaint(
                            painter: _PointPainter(
                              points: _points,
                              scale: _calculateImageScale(
                                constraints.biggest,
                                _originalImageWidth!,
                                _originalImageHeight!,
                              ),
                              offset: _imageOffset,
                              isScale: _isSettingScale,
                            ),
                            size: Size.infinite,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                    if (_image == null)
                      ...[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: _takePhoto,
                            child: const Text("Take Photo", style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: _pickFromGallery,
                            child: const Text('Gallery', style: TextStyle(color: Colors.white, fontSize: 16)),
                          ),
                        ),
                      ]
                    else
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              _image = null;
                              _points.clear();
                              _isSettingScale = true;
                              _imageDisplaySize = null;
                              _originalImageWidth = null;
                              _originalImageHeight = null;
                              _scaleController.clear();
                            });
                          },
                          child: const Text('Reset', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                  ],
                  ),
                  
                  if (_image != null)
                    _isSettingScale
                        ? Column(
                          
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      controller: _scaleController,
                                      decoration: const InputDecoration(labelText: 'Length'),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: DropdownButtonFormField<String>(
                                      value: _lengthUnit,
                                      decoration: const InputDecoration(
                                        labelText: 'Unit',
                                        // border: OutlineInputBorder(),
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                      ),
                                      items: const [
                                        DropdownMenuItem(value: 'cm', child: Text('cm')),
                                        DropdownMenuItem(value: 'm', child: Text('meter')),
                                      ],
                                      onChanged: (val) {
                                        setState(() {
                                          _lengthUnit = val!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                onPressed: _points.length == 2 ? _setScaleReference : null,
                                child: const Text('Set Scale'),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Text('${_points.length}/4 corners tapped'),
                              if (area != null)
                                _lengthUnit == 'm'
                                  ? Text('Area: ${(area / 10000).toStringAsFixed(4)} m²')
                                  : Text('Area: ${area.toStringAsFixed(2)} cm²'),
                            ],
                          ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PointPainter extends CustomPainter {
  final List<Offset> points;
  final double scale;
  final Offset offset;
  final bool isScale;

  _PointPainter({required this.points, required this.scale, required this.offset, required this.isScale});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isScale ? Colors.green : Colors.red
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      final screenPt = Offset(points[i].dx * scale + offset.dx, points[i].dy * scale + offset.dy);
      canvas.drawCircle(screenPt, 8, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _PointPainter old) => old.points != points;
}