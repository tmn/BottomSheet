# BottomSheet

A SwiftUI Component for showing a Map like bottom sheet. 

## Usage

Add a package to your Xcode project by select _File_ > _Swift Packages_ > _Add Package Dependency_ and enter `https://github.com/tmn/BottomSheet`.

```swift
struct ContentView: View {
    @State var viewState: BottomSheetViewState = .peek

    var body: some View {
        ZStack {
            Color.pink

            BottomSheet(viewState: self.$viewState) {
                Text("Sheet content")
            }
        }
    }
}
```
