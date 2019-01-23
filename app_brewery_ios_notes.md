# App Brewery iOS Bootcamp Notes

## When is a good time to join the Apple Developer Program?
Delay until you have an app ready to upload to the app store.
It costs $99 dollars, and there's no benefit unless you're releasing an app.

## Should I make an mobile app?
If it's just information retrieval or it doesn't require the unique features of a phone, do not! Make a a website instead.

## When do you validate your app idea?
Ask everybody you know and don't know, people at the grocery store if it's a good idea first. Do **not** build it first!

## If This Then What?
Any one who builds products should constantly think about this.
- Example: Angela You read an article about 36 questions that lead to love and made an app about it, forgot about it, and it went viral.
- Anything that causes you pain, that you can make an app solution for, will probably help at least a hundred thousand people.

## Do you need an NDA to discuss your app idea?
No. VC's will tell you 5 people already have your idea and are working on it - it's the blood, sweat, and tears that make it special.

## Making Assets
- Generate art asset from a single image: <https://appicon.co>
- Make app icon: <https://www.canva.com>

## Common Beginner Error: Unknown Key Exception
- Probably changed the name of an code outlet, but not the storyboard asset.
- Delete code and delete outlet link.
- Next time, right click on code name, and select refactor/rename.

## Sideloading (Put your dev app on your phone)
- iOS and xCode versions must match! 12.1 and 10.1 for example. IOS 10.0 & Xcode 12.1 will not work!
- You must enter Team under main settings
- Select your device for the build device.
- Make sure your bundle indentifier is unique.
- You must connect via chord the first time.
- Afterwords you connect successfully you can then connect wirelessly by clicking Window/Devices and Simulators/Connect via network.

## Button Tags
- Buttons have a tag property which holds an integer
- Useful for simplifying functions

## Copy / Pasting
- Be careful with braces. They are a huge source of bugs!

## Implementing New features
- Overview
  - work from the specific to the general.
  - get code samples to work, *then* learn the technology
- Start with <http://stackoverflow.com>. Cut and paste, and fiddle with the code until it works. Then read up on the docs to learn about the solution.
- Next try <https://forums.developer.apple.com>. Another question and answer format.
- Next try <https://developer.apple.com/reference>. Search is bad, but persevere and you could be rewarded with great docs. Note that a lot of code is Objective-C, so it's not a good starting point. It's better if you already have good code, and want to learn about it.

## Good Error Code Lookup
<https://osstatus.com>

## Alerts
- Overview
  - Same as a Javascript alert (popup)
  - Shows a message to the user
  - Is an interruption, use sparingly
  - An alert has two **styles**:
    1. Modal Alert: Popup in middle of screen
    2. Action Sheet: Multiple options in the bottom of the screen
  - You add **UIAlertActions** to the UIAlertController when you want a button to do something.
  - Your present the alert
  - Docs:
    - <https://developer.apple.com/documentation/uikit/uialertcontroller>
    - <https://developer.apple.com/documentation/uikit/uialertaction>

## Autolayout
- Ultimately, the computer is going to render a box and it needs to know the origin and the size (width & height)
- There are two methods that the computer accepts:
  1. Pin Method: Give it the the left, right, top, and bottom distance to the edge or margin.  Computer calculates the origin and size.
  2. Alignment method: give it the size (width & height) and the alignment (align center or the x and y edges)
- Containers - Good method:
  - Make container views (boxes) for every row.
  - Pin each row all around.
  - Color the containers background to test on different devices, make transparent (default color) when your done
  - Nest your objects in the containers by aligning or pinning.
- Stackviews:
  - Flexbox for iOS
  - Choosable alignment like equal fill, or proportional fill
  - How to:
    - Usually choose equal fill, or play with the options (they're easy!)
    - For proportional fill (ex: 0 key of the Apple calculator takes the space of two buttons)
      1. Set equal width constraint on the children
      2. Set multiplier of that equal width constraint to 1:2 (eg)
      3. Set stack view to proportional fill

## Delegation & Protocol Pattern
  - What: allows a child object to pass data to a parent object. It's a kind of OO lambda.
  - A major feature is that ObjectA and ObjectB contain references to each other, and do not perpetually create new objects. An inefficient alternative would be ObjectA passes data to new instance of ObjectB, and Object B then creates a new ObjectA upon return!
  - How to implement:
    - ObjectA *prepares_a_segue* for ObjectB, and instantiates the segue.destination as ObjectB controller and assigns itself as ObjectB's delegate
    ```
    let ObjectB = segue.destination as! ObjectBController
ObjectB.delegate = self
  ```
      Any data to be passed to be ObjectB gets assigned to ObjectB properties.
    - ProtocolForB: contains a function(s) in which data can be passed in the methods. Think of the protocol as a lambda.
    - ObjectB:
      -Contains a delegate which is assigned as the optional ProtocolForB
      -Whenever data needs to be passed ObjectB calls `delegate.protocal_method(data_to_be_passed)`
      - ObjectB can `dismiss` itself, which automatically destroys itself, and sends the screen back to ObjectA

## Closure Syntax
All are equivalent
```swift
// Complete form
{ (i: Int) -> Int in
  return i + 1
}

// Return not required
{ (i: Int) -> Int in
  n + 1
}

// Use type inference
{ (i) in
  i + 1
}

// Use shorthand notation
{ $0 + 1 }
```
Eg
```swift
// Full version
[1, 2, 3].map({(i: Int) -> Int
  return i + 1
})

// Shorthand version
[1, 2, 3].map { $0 + 1 }
```
A function which takes a function in the last position can drop the final parenthesis.
```swift
// Long version
calculate(a: Int, b: Int, {(x: Int, y: Int) -> Int in
  return x + y
})

// Closure in parenthesis
calculate(a: Int, b: Int, { $0 + 1 })

// Trailing syntax version
calculate(a: Int, b: Int) { $0 + 1 }
```
## Why Firebase?
- Firebase is Google's NoSQL Realtime database.
- From [codementor](https://www.codementor.io/cultofmetatron/when-you-should-and-shouldn-t-use-firebase-f62bo3gxv)
  - "Firebase's realtime database is a very powerful tool for a limited scope. To know if your data is a good match for Firebase, simply ask yourself if you'd want to use a observable hash. If all you need is to react to the addition/update of items in a collection or object, Firebase is great. If you need extensive queries or have complex relational data, Firebase would be a poor choice for your main database. Still, it could still be an excellent component of a well balanced server side infrastructure."

## Data Storage Options
- UserDefaults
  - Should be used for simple key value pairs, but can take any object
  - Methods: `set` & <name of type> like `string`
