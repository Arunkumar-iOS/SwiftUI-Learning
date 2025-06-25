## Networking 📲

When you implementing Network service always check these points, and refer the sample project if you need.

![](Readme_Images/1.png)

Update view on main thread
 Any code that updates the user interface must run on the main thread. If an asynchronous(background thread) method contains code that updates the user interface, it must somehow run that code on the main thread.

 ```swift
await MainActor.run {
// update here.
  objects.append(object)
}
```

Showing a ProgressView 

```swift
.overlay {
  if store.objects.isEmpty { ProgressView() }
}
```
