# ChromaDiary
## HuesOfMe 🎨

*A mindful, visual journal to help you understand your emotional world through color.*

![SwiftUI](https://img.shields.io/badge/SwiftUI-darkgreen.svg) ![SwiftData](https://img.shields.io/badge/SwiftData-orange.svg) ![WidgetKit](https://img.shields.io/badge/WidgetKit-blue.svg) ![iOS](https://img.shields.io/badge/iOS-17%2B-purple.svg)

This project is my answer to a simple question: What if journaling could be as intuitive and expressive as choosing a color?

---

*(Tip: To create a great demo GIF, record your app in the Simulator using QuickTime, then use a free online tool or an app like Giphy Capture to convert the video to a GIF.)*

![Demo GIF of HuesOfMe](placeholder_for_your_demo.gif)

## The "Why" - My Motivation

I've always found traditional journaling a bit intimidating. The pressure to fill a blank page with the "right" words can feel like a chore, and I realized that often, a feeling is more immediate and visceral than a sentence. I wanted to create an experience that was more fluid, personal, and beautiful.

I built **HuesOfMe** to transform self-reflection from a task into a creative, visual experience. It’s a calm, beautiful space where I can log my emotions as colors, adding notes only when I feel inspired. Over time, it doesn’t just build a log; it paints a vivid, glanceable mosaic of my inner world.

## ✨ A Glimpse Inside

Here's what makes HuesOfMe special:

* 🎨 **A Dynamic, Color-Centric Dashboard:** The main screen is your canvas for the day. It features a clean, interactive date selector and a scrolling list of your daily entries, with each note's background vividly reflecting the color you chose for that moment.

* 📅 **The "MoodScape" Calendar:** This isn't just a grid of dates; it's a heatmap of your emotional journey. The calendar provides a full monthly layout, allowing you to see your logged moods at a glance. Tapping any day instantly takes you to a detailed view of all the entries you made on that specific date.

* 🌈 **Unlimited Color Expression:** To ensure complete creative freedom, the app includes a full-spectrum **Color Picker**. This lets you find the exact hue that matches your feeling, from a vibrant, energetic red to a calm, muted blue.

* 🔥 **Streaks & Motivation:** To encourage the healthy habit of daily reflection, the app tracks and displays your daily logging **streak** on the dashboard—a simple but powerful motivator to help you build a consistent mindfulness practice.

* 🔔 **Gentle Reminders:** HuesOfMe helps you stay consistent with optional, non-intrusive **daily notifications**. It’s a gentle nudge in the evening asking, "How are you feeling?" designed to feel like a caring friend, not an alarm.

* 📱 **Home Screen Widget:** The experience extends beyond the app. The Home Screen **Widget** displays the color of your most recent entry, serving as a beautiful, glanceable reminder of your last check-in.

## 🛠️ My Tech Stack & Learning Journey

This project was a deep dive into building an app that not only works well but *feels* great to use, focusing on Apple's modern development ecosystem.

* **SwiftUI:** The entire user interface is built declaratively with SwiftUI. This allowed me to create a responsive, component-based design with beautiful animations and a theme system that instantly changes the app's entire appearance.

* **SwiftData:** For all on-device persistence, I used the latest SwiftData framework. The power of the `@Query` property wrapper and custom predicates made creating a real-time, data-driven experience for the dashboard and calendar incredibly efficient.

* **WidgetKit & App Groups:** One of the most interesting challenges was sharing data between the main app and the Home Screen widget. I learned to implement **App Groups** to create a secure, shared data container for SwiftData, allowing the widget to always show the latest entry.

* **UserNotifications:** To build the gentle reminder feature, I used the UserNotifications framework, learning how to request permission and schedule repeating, time-based local notifications.

* **Apple's HIG:** I was deeply inspired by Apple's Human Interface Guidelines. I focused on **Clarity** (a clean, understandable interface), **Deference** (the UI supports the content without overwhelming it), and **Depth** (using layers and smooth transitions to create a tangible, intuitive experience).

## ⚙️ How to Run

1.  Clone the repository.
2.  Open the `.xcodeproj` file in Xcode.
3.  Select the `HuesOfMe` scheme.
4.  Run on a physical device or simulator.
