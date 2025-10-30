# Star Wars Planets (iOS)

## Overview
Displays Star Wars planets using SWAPI. Shows a list (name, climate) and a detail view (name, orbital period, gravity) with placeholder images from picsum.photos.

Displays Star Wars planets using SWAPI. Shows a list and a detail view with a random image from picsum.photos

## Tech
- Swift 6, Xcode 26.0
- SwiftUI
- Swift concurrency (async/await)
- Combine
- CoreData
- SwiftTesting & XCTest

## Run
1. Open `StarWarsPlanets.xcodeproj` in Xcode.
2. Select `development` schema
3. Build and run on iOS Simulator.

## Design decisions
- MVVM architecture provides a clear separation of UI and business logic
- Repository Layer, Repository pattern allows flexible data source management between online and offline using a single abstraction 
- Clear separation: APIClient → Repository → ViewModel → View.
- Alamofire for networking, simplifies async network calls with JSON decoding and retry mechanisms
- SDWebImage for proper image loading and caching
- CoreData for offline data caching, as it has buit in support compared to third party frameworks like SQLlite
- Used XCConfig with separate schemas to differentiate build environments. (Eg: Development, Staging, Production). This will make it easier to manage different configs per environment such as REST API base url