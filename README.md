## About

• MultiSearch is a reference iPhone tab bar app I wrote that searches Google, DuckDuckGo and Bing using their respective APIs.

• Select the iPhone 11 Pro simulator and use it for everything. The view controller snapshot tests will fail otherwise.

• Use the "MultiSearch" scheme for everything except running Spanish language tests (see below).

• The app supports dark and light mode.

• The app is localized to support English and Latin-American Spanish (although search engine results are only English).

• View are built three ways: UIKit w/ Storyboard (DuckDuckGo), Declarative UIKit (Google), and SwiftUI (Bing)

## Testing

• The project is configured to use Test Plans, so running tests manually does not work.

• To run the English tests, select "MultiSearch", tap command-u, then view results in Test Plan Navigator.

• To run the Spanish tests, select "MultiSearch Spanish (Latin America)", tap Command-U, then view results in the Test Plan Navigator.

• This app depends on swift-snapshot-testing which is included via the Swift Package Manager.

## Errata

• In Xcode 13.1 (the latest version currently runnable on my machine), the view controller snapshot tests fail
  due to claimed insufficient permissions on a cloned repository. Hopefully this problem does not persist in newer
  versions of Xcode, but I am doubtful ;)
