
## Errata

• In Xcode 13.1 (the latest version currently runnable on my machine), the view controller snapshot tests fail
  due to claimed insufficient permissions on a clone of this repository. Hopefully this problem does not occur in newer
  versions of Xcode.

## About

• MultiSearch is an iPhone tab bar app I wrote that searches Google, DuckDuckGo and Bing using their respective APIs.

• Select the iPhone 11 Pro simulator and use it for everything. The view controller snapshot tests will fail otherwise.

• Use the "MultiSearch" scheme for everything except running Spanish language tests (see below).

• The app supports dark and light mode.

• The app is localized to support English and Latin-American Spanish.

• View are built three ways: UIKit w/ Storyboard (DuckDuckGoSearch), Declarative UIKit (GoogleSearch), and SwiftUI (BingSearch)

## Testing

• The project is configured to use Test Plans, so running tests manually does not work.

• To run the English tests, select "MultiSearch", tap command-u, then view results in Test Plan Navigator.

• To run the Spanish tests, select "MultiSearch Spanish (Latin America)", tap command-u, then view results in Test Plan Navigator.

• This app depends on swift-snapshot-testing which is included via the Swift Package Manager.
