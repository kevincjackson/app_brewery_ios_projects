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
  - Example implementation: here a story board has two view controllers, MainViewController and VolumeViewController. Main has a label that shows the volume, and button which goes to the volume screen, using a segue called "gotoVolumeView". The volume screen has a volume slider, and done button.
  
  ```swift
  // Main View Controller, the "Parent"
  class MainViewController: UIViewController {

    var currentVolume: Float = 5
    @IBOutlet weak var volumeLabel: UILabel!
    
    // Goto volume view screen with the button is pressed
    // performSegue() along with dismiss() are the main two methods opening and closing a modal type screen.
    @IBAction func volumeButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "gotoVolumeView", sender: self)
    }
    
    // prepare(for segue) is the main method used to set up the modal
    // a UIStoryboardSegue is an object, whose main purpose is to hold a reference to the source and destination
    // view controllers, in properties called source and destination.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoVolumeView" {
        
            // segue.destination has a type of UIViewController
            // as! casts the view controller to our desired view controller
            // without the case, we do not have access to our desired view controllers properties and methods.
            let volumeVC = segue.destination as! VolumeViewController
            
            // delegation is a technique in which a reference is held to a sender and a receiver.
            // here the reciever is being identified as self (this view controller)
            volumeVC.delegate = self
            
            // notice we have access to the destination view controllers properties, as noted above.
            volumeVC.volume = currentVolume
        }
    }
}

//  Here, main view controller satisfies the requirements of being a delegate
extension MainViewController: VolumeViewDelegate {
    func volumeDidFinishUpdating(level: Float) {
        currentVolume = level
        volumeLabel.text = String(currentVolume)
    }
}

// A protocol is just a blue print. 
protocol VolumeViewDelegate {
    func volumeDidFinishUpdating(level: Float)
}

// The "Child" View Controller
class VolumeViewController: UIViewController {
    
    // Very important: this this class as the sender.
    var delegate: VolumeViewDelegate?
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    var volume: Float = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        volumeSlider.setValue(volume, animated: false)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
    
        // Here the delegate is sent a message. 
        delegate?.volumeDidFinishUpdating(level: volumeSlider!.value)
        dismiss(animated: true, completion: nil)
    }
}
  ```

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
  - Should be used for simple key value pairs
  - Can take native collections, but not custom objects.
  - Methods: `set` & <name of type> like `string`
- Codable
  - Same custom objects to Plist or JSON.
  - Slow lookup. Keep file under 100k.
- Keychain
  - Store secure data
- SQLite
  - Handles large datasets
  - Fast Search
- FMDB
  - iOS wrapper (pod) for SQLite
- Core Data
  - Object-oriented database
  - Underneath is SQLite DB
  - Language
    - Entity = Class
      - Codegen
        - Class Definition - class automatically created
        - Category Extension - add to automatically created Class
        - None - you write your own class code
    - Attribute = Property
    - NSPersistentContainer = SQLite DB
    - Context = temporary scratchpad used before saving
- Realm
  - Simpler API than CoreData
  - Less lines of code
  - Faster than CoreData
  - Uses SQLite as well

## NSPredicate
- Query Language
- SQL Where clause meets regular expression
- Uses natural language
- Checkout this cheatsheet:
<https://academy.realm.io/posts/nspredicate-cheatsheet/>

## In App Purchases
- Strategy
  - Put 80% functionality free
  - Put 20% behind pay well
  - Example:
- Purchase must be digital, not physical
- Apple takes 30%.
- Uses *StoreKit* framework
- Must supply a `Restore purchase` button
  - Save user data in UserDefaults
  - Validate user data against Apple services

## Handling Optionals
- `!`: Use to catch logic errors
- `guard` : Use to catch logic errors with a custom message
- `if let` : Use when multiple allowed paths exist.
- `??`: Use when multiple allowed paths exist, good for defaults

## Access Levels
- private: class only
- file private: all classes in the file
- internal (default): project wide
- public: other projects can use, but not override
- open: other projects can use, and override.

## Freelancing
0. Dedicate 10-15 hours / week
1. Personal Projects
2. Fivr (not for money, but experience)
3. Upwork

## Best Developer Tools
- Duet
- Alfred
- Momento, Chrome plugin
- Cheatsheet
- Canned Emails (Humor)

## Color for Apps
| Color | Mood |
| - | - |
| Red | Love, Energy, Intensity |
| Yellow | Joy, Intellect, Attention |
| Green | Freshness, Safety, Growth |
| Blue | Stability, Trust, Serenity |
| Purple | Royalty, Wealth, Feminity |

| Scheme | Usage |
| - | - |
| Analogous | Harmonious for Main Interface, BG |
| Complementary | Max Attention for Logo |
| Split Complementary, Triadic | Moderate Attention for Logo |
| Monochrome | Harmonious for Interfaces |

## Color Tools
- <http://colorhunt.com> Curated collection of colors
- <http://flatuicolors.com> iOS rainbow
- <http://materialpalette.com> android rainbow
- colorzilla: browser color sampler

## Typography
- Serif (Dutch for line): More conservative, think law office
  - Modularation (thick / thin) increases
  - Subdivisions
    - Old Style
    - Traditional
    - Modern
    - Slab serif: Oddball, thick fonts used for poor resolution printing
- San serif: More
  - Modulation increases
  - Subdivisions
    - Grotesque
    - Neo-Grotesque
    - Humanist: Reads faster
    - Geometric: Oddball, equidistant at all points
- Combining
  - Heading and body get opposing Serif and San-serif, or vice versa. Don't mix serif with serif, etc.
  - Use two different fonts. Three is a stretch. Four is too many.
  - Fonts have moods just like colors. Make sure the mood fits.
  - Tips
    - Match moods.
    - Match time eras.
    - Contrast serifs vs sans-serifs.
    - Contrast weights.
    - Don't ever use these:
      - Comic sans
      - papyrus
      - kristen
      - viner
      - curlz

## Typography Tools
- WhatFont: browser font identifier
- <http://fontsquirrel.com> free for commercial use
- <http://skyfonts.com> new fonts for apps

## Typography Reading
- Thinking with Type
- Element of Typographic Style
- Just My Type
