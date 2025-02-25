# Floating Hearts Animation

A Flutter package that provides a beautiful floating hearts animation effect when tapped. Perfect for like buttons, favorites, or any interaction that could use some visual flair.

## Demo

![Floating Hearts Animation Demo](https://raw.githubusercontent.com/dustinchu/floating_hearts_animation/main/screenshots/demo.gif)

## Features

- Customizable floating hearts animation
- Simple to integrate into any Flutter project
- Configurable size and appearance
- Support for custom SVG icons or your own widgets
- Multiple animation types (linear, curve, random)
- Adjustable animation duration and delays
- Control over the number of floating items

## Getting started

Add this package to your pubspec.yaml:

```yaml
dependencies:
  floating_hearts_animation: ^0.0.1
```

You'll also need to ensure you have flutter_svg in your dependencies:

```yaml
dependencies:
  flutter_svg: ^2.0.17 # Or later version
```

## Usage

```dart
import 'package:floating_hearts_animation/floating_hearts_animation.dart';

// Basic usage with SVG
FloatingHeartsButton(
  svgPath: 'assets/heart.svg', // Path to your heart SVG
  size: 50, // Size of the button
  onTap: () {
    // Handle tap event
    print('Heart tapped!');
  },
)

// Or with a custom widget
FloatingHeartsButton(
  child: Icon(Icons.favorite, color: Colors.red, size: 50),
  onTap: () {
    print('Heart tapped!');
  },
)
```

Don't forget to add your SVG assets to your pubspec.yaml:

```yaml
flutter:
  assets:
    - assets/heart.svg
```

## Example

Here's an example of how to implement the floating hearts animation in a Flutter app:

```dart
import 'package:flutter/material.dart';
import 'package:floating_hearts_animation/floating_hearts_animation.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({Key? key}) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return FloatingHeartsButton(
      svgPath: 'assets/heart.svg',
      size: 40,
      floatingItemCount: 5,
      animationType: FloatingAnimationType.curve,
      animationDuration: Duration(milliseconds: 2000),
      itemDelay: Duration(milliseconds: 150),
      onTap: () {
        setState(() {
          isLiked = !isLiked;
        });
        print('Like status: $isLiked');
      },
    );
  }
}
```

## Customization

You can customize the appearance and behavior of the floating hearts animation:

| Parameter           | Type                  | Default  | Description                                                       |
| ------------------- | --------------------- | -------- | ----------------------------------------------------------------- |
| `svgPath`           | String?               | null     | Path to the SVG asset to use (required if child is null)          |
| `child`             | Widget?               | null     | Custom widget to use instead of SVG (required if svgPath is null) |
| `size`              | double                | 50.0     | Size of the main button                                           |
| `onTap`             | VoidCallback          | required | Callback function when button is tapped                           |
| `floatingItemCount` | int                   | 3        | Number of floating items to show when tapped                      |
| `animationDuration` | Duration              | 1500ms   | Duration of each floating animation                               |
| `itemDelay`         | Duration              | 300ms    | Delay between each floating item's animation start                |
| `animationType`     | FloatingAnimationType | random   | Type of animation (linear, curve, random)                         |
| `floatingItemScale` | double                | 0.6      | Size scale of floating items relative to the main button          |

### Animation Types

- `FloatingAnimationType.linear`: Items float straight up
- `FloatingAnimationType.curve`: Items float up in alternating left-right pattern
- `FloatingAnimationType.random`: Items float up with random horizontal offsets

## Contributing

Contributions are welcome! If you find a bug or want a feature, please open an issue.
If you'd like to contribute to the code:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Additional information

This package is maintained by Dustin Chu. For bug reports and feature requests, please open an issue on GitHub.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
