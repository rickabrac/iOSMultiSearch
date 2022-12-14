
## About

• MultiSearch is a reference iPhone tab bar that searches Google, DuckDuckGo and Bing using APIs.

• Use the iPhone 11 Pro simulator for everything.

• Use the MultiSearch scheme for everything except Spanish language tests (see below).

• This app supports both dark and light mode.

• This app is localized for English and Latin-American Spanish (search engine results are only in English).

• Views are built three ways: UIKit/Storyboard (DuckDuckGo), Declarative UIKit (Google), and SwiftUI (Bing)

## Testing

• The project is configured to use Test Plans.

• To run English tests, select the MultiSearch scheme, tap command-u, and view results in Test Plan Navigator.

• To run Spanish tests, select the "MultiSearch Spanish (Latin America)" scheme, tap command-u, and view results in Test Plan Navigator.

## Notes

• This app depends on swift-snapshot-testing, which is included via the Swift Package Manager.

## Errata

• In Xcode 13.1, view controller snapshot tests may fail due to claimed insufficient permissions on a cloned repository.
