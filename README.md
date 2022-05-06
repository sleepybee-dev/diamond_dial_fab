# diamond_dial_fab
Diamond shaped floating action button with dials. 

## Screenshot
![screenshot](https://user-images.githubusercontent.com/88768221/166952843-b69a6dfa-95b2-4cd8-8b8c-2859a8b97a6d.gif)

## Usage
- Add the dependency to your pubspec.yaml file.
```yaml
dependencies:
    flutter:
      sdk: flutter
    diamond_dial_fab: 0.0.1
```
- Add DiamondDialFab in your Scaffold Widget like any FAB.
```dart
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
          DiamondDialFab(
            children: [
              DiamondDialChild(
                child: const Icon(Icons.wine_bar),
                label: "Wine Bar",
              ),
              DiamondDialChild(
                child: const Icon(Icons.wc),
                label: "Toilet"
              )
            ]
          ),
                ....
```
## Customize

The following options are available for DiamondDialFab:

| Property | Type | Description |
|----|----|----|
|`children`|`List`|List of `DiamondDialChild`|
|`buttonSize`|`double`|Size of main FAB.|
|`mainIcon`|`Icon`|Main FAB Icon|
|`mainBackgroundColor`|`Color`|Background color of main FAB Icon|
|`mainForegroundColor`|`Color`|Background color of main FAB Icon|
|`pressedIcon`|`Icon`|Main FAB Icon when pressed|
|`pressedBackgroundColor`|`Color`|Background color of main FAB Icon|
|`pressedForegroundColor`|`Color`|Background color of main FAB Icon|
|`cornerRadius`|`double`|Radius of diamond's corners. It should be under the quarter of buttonSize.|
|`dimOverlay`|`DimOverlay`|`.dark`, `.light` or `.none`.|
|`dimOpacity`|`double`|It should be under 1.0|
|`childLabelLocation`|`LabelLocation`|`.left` or `.right`. It is not depends on location of the main FAB, you should apply it manually.|
|`childrenButtonSize`|`Size`|Size of children FAB.|
|`notifierIsOpen`|`ValueNotifier<bool>`|You can be notified if FAB opens.|
|~~`animationSpeed`~~|`int`|It is not working yet.|
|~~`heroTag`~~|`String`|It it not working yet.|

## License
MIT License