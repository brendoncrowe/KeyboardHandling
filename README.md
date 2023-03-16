# Keyboard Handling
For many iOS applications, keyboard handling is very important. For a seamless user experience, the keyboard should not be covering important views
such as buttons, labels, text fields, etc.

To fix this issue if it arrises, a good implementation is to capture the keyboard appearing and disappearing via the NotificationCenter.

### Human Interface Guideline regarding keyboard (Photo credit @ apple inc.)
![Keyboard-Photo](Assets/KeyboardGuidelineImage.png)


### Example 
![Gif](Assets/KBHandling.gif)

Notice that the view moves up when the keyboard appears and moves back down when the keyboard disappears (pulsing animation is not relevant but there cause why not?!)

There are several steps needed to achieve this result.
