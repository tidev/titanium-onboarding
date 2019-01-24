# titanium-onboarding

Titanium module for the popular [PaperOnboarding ](https://github.com/Ramotion/paper-onboarding) Swift UI library.

## Requirements

- [x] Titanium SDK 8.0.0+
- [x] iOS: Swift 4.2

**NOTE**: The iOS module is built with Swift 4.2. Because of Swift's still missing ABI stability, you need to have the same Swift version installed that was used to build the release version of this module. You can check your current Swift version by using `swift -v` from the terminal.

# Installation

Install the module to your project or globally by copying it into the modules folder. After that enable it in your tiapp.xml.

```xml
<modules>
  <module platform="iphone">ti.onboarding</module>
</modules>
```

## Usage

To create a new onboarding process simply use the module's `createView` method and pass the options you need.

```js
var onboarding = require('ti.onboarding');
var win = Ti.UI.createWindow({
  backgroundColor:'white'
});
var onboardingView = onboarding.createView({
  items: [{
    title: "Titanium + Swift",
    description: "You can now use Swift to write native modules in Titanium!",
    informationImage: '/images/titanium-logo.png',
    pageIcon: '/images/titanium-logo.png'
  },{
    title: "Titanium + Swift",
    description: "You can now use Swift to write native modules in Titanium!",
    informationImage: '/images/titanium-logo.png',
    pageIcon: '/images/titanium-logo.png',
    color: 'green'
  }]
})
win.add(onboardingView);
win.open();
```

See the API reference for available options.

## API Reference

### OnboardingModule

#### createView

`createView(options)`

Creates a new onboarding view with the specified items and other options.

**Parameters**

| Name | Type | Description |
| --- | --- | --- |
| `items` | `Array<OnboardingItem>` | Array of onboarding items. At least one item is required for the view to properly render. See the [OnboardingItem](#onboardingitem) reference for available options. |
| `beforeTransition` | `Function` | Function to be called before item transition. Received the index of the item  |
| `afterTransition` | `Function` | Function to be called after item transition. |
| `defaultItemColor` | `String` | The default item background color if none specified in the item (defauts to `white`). |
| `defaultItemTitleColor` | `String` | The default color of the title text if none specified in the item (defauts to `black`). |
| `defaultItemDescriptionColor` | `String` | The default color of the description text if none specified in the item (defauts to `gray`). |
| `defaultItemTitleFont` | `String \| Font` | The default font of the title text if none specified in the item (defauts to 36pt bold system font). |
| `defaultItemDescriptionFont` | `String \| Font` | The default item background color of none specified in the item (defauts to 14pt system font). |
| `pageItemColor` | `Function` | Optional function that can be used to adjust the color of an item's bottom page indicator. Receives the item index as a parameter. |
| `pageItemRadius` | `Number` | Radius of the bottom page indicator for an item (defaults to `8`). |
| `pageItemSelectedRadius` | `Number` | Radius of the bottom page indicator for the selected item (defaults to `22`). |

**Returns**

OnboardingView

### OnboardingView

#### currentIndex

`currentIndex : Number`

Property to retrieve the currently selected item index.

<hr>

#### transitionToIndex

`transitionToIndex(index, animated)`

**Parameters**

| Name | Type | Description |
| --- | --- | --- |
| index | `Number` | Index of the item to transition to. |
| animated | `Boolean` | Specifies if the transition should be animated. Defaults to `true`. |

### OnboardingItem

Each item represents a page during the onboarding process.

| Name | Type | Description |
| --- | --- | --- |
| `title` | `String` | Title of the onboarding item |
| `description` | `String` | Description of the onboarding item |
| `informationImage` | `String \| Ti.File \| Ti.Blob` | Big information image of the onboarding item |
| `pageIcon` | `String \| Ti.File \| Ti.Blob` | Page icon of the item at the bottom of the onboarding screen |
| `color` | `String` | Background color of the onboarding item (optional) |
| `titleColor` | `String` | Color of the title text (optional) |
| `descriptionColor` | `String` | Color of the description text (optional) |
| `titleFont` | `String \| Font` | Font of the title text (optional) |
| `descriptionFont` | `String \| Font` | Font of the description text (optional) |

## Contributions

Open source contributions are greatly appreciated! If you have a bugfix, improvement or new feature, please create
[an issue](https://github.com/appcelerator-modules/titanium-sonboarding/issues/new) first and submit a [pull request](https://github.com/appcelerator-modules/titanium-socketio/pulls/new) against master.

## Getting Help

If you have questions about the Onboarding module for Titanium, feel free to reach out on Stackoverflow or the
`#helpme` channel on [TiSlack](http://tislack.org). In case you find a bug, create a [new issue](/issues/new)
or open a [new JIRA ticket](https://jira.appcelerator.org).

## License

Apache License, Version 2.0