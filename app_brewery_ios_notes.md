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
- Be very careful to identify braces. They are a huge source of bugs.

## Implementing New features
- Overview
  - work from the specific to the general.
  - get code samples to work, then learn about that code
- Start with <http://stackoverflow.com>. Cut and paste, and fiddle with the code until it works. Then read up on the docs to learn about the solution.
- Next try <https://forums.developer.apple.com>. Another question and answer format.
- Next try <https://developer.apple.com/reference>. Search is bad, but persevere and you could be rewarded with great docs. Note that a lot of code is Objective-C, so it's not a good starting point. It's better if you already have good code, and want to learn about it.

## Good Error Code Lookup
<https://osstatus.com>
