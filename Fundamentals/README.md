# 🧠 SwiftUI Developer Cheat Sheet

A personal reference for SwiftUI basics, view modifiers, MVVM, and navigation patterns — built as I learn.

---

## 📚 Table of Contents

- [🧭 Navigation](#-navigation)
- [🔁 State & Binding](#-state--binding)
- [🧩 View Modifiers](#-view-modifiers)
- [📦 MVVM Pattern](#-mvvm-pattern)
- [📋 Lists](#-lists)
- [🪄 Buttons](#-buttons)
- [⚠️ Alerts & Sheets](#-alerts--sheets)
- [🧰 ViewModifiers](#-viewmodifiers)
- [📌 Previews with SwiftData](#-previews-with-swiftdata)
- [📝 TextFields & Forms](#-textfields--forms)
- [🔄 ForEach](#-foreach)
- [🎨 Fonts & Colors](#-fonts--colors)
- [🟦 Empty State View](#-empty-state-view)
- [✅ Swipe Left & Right in List](#-swipe-left--right-in-list)
- [🛠 Toolbar Usage](#-toolbar-usage)
- [📍 Place a View at the Bottom of the Screen](#-place-a-view-at-the-bottom-of-the-screen)
- [💡 Tips](#-tips)

---

## 🧭 Navigation

## `NavigationStack`

This guide covers the 3 main navigation approaches in SwiftUI using `NavigationStack`, `NavigationLink`, and `NavigationPath`. Each example includes comments to help you apply them in your own app.

### ✅ 1. NavigationLink with Static Destination

Use case: Basic navigation with direct destination.

```swift




Use case: Basic navigation with direct destination.

```swift
import SwiftUI

struct StaticLinkExample: View {
    var body: some View {
        NavigationStack {
            VStack {
                // 👇 Static destination using NavigationLink
                NavigationLink("Go to Next Screen") {
                    // 🔁 This will be the next view shown when tapped
                    EmptyView()
                }
            }
            .navigationTitle("Static Link")
        }
    }
}
```

### ✅ 2. NavigationLink with value and .navigationDestination(for:)

Use case: Dynamic destinations, enum or value-driven routing.

```swift
import SwiftUI

struct ValueLinkExample: View {
    @State private var selectedValue: String?

    var body: some View {
        NavigationStack {
            VStack {
                // 👇 NavigationLink using value
                NavigationLink("Go to Value-Based Screen", value: "go")

                // 👇 You can also navigate programmatically
                Button("Navigate with value") {
                    selectedValue = "go"
                }
            }
            // 👇 This defines what screen to show for the given value
            .navigationDestination(for: String.self) { value in
                // 🧠 You can return different views based on value
                EmptyView()
            }
            .navigationTitle("Value Link")
        }
    }
}

```

### ✅ 3. NavigationStack with path (Programmatic Navigation)

Use case: Full programmatic navigation, custom routing, deep linking, push/pop multiple screens.

```swift
import SwiftUI

struct PathBasedExample: View {
    // 👇 Holds the entire stack of views
    @State private var path: [String] = []

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                // 👇 Navigate to a single screen
                Button("Go to Screen 1") {
                    path.append("screen1")
                }

                // 👇 Navigate multiple screens deep instantly
                Button("Go to 3 Screens") {
                    path = ["screen1", "screen2", "screen3"]
                }

                // 👇 Pop back to root
                Button("Pop to Root") {
                    path = []
                }
            }
            // 👇 Dynamically handle what view to show based on current path value
            .navigationDestination(for: String.self) { value in
                // 🔁 Each value in `path` pushes a view here
                EmptyView()
            }
            .navigationTitle("Path Based")
        }
    }
}
```

---
## ✅ Swipe Left & Right in List

Use `.swipeActions(edge:)` to add buttons when swiping left or right on a row in a `List`.

```swift
.swipeActions(edge: .leading) {
    Button("Delete", role: .destructive) {
        withAnimation {
            modelContext.delete(item)
        }
    }
}
.swipeActions(edge: .trailing) {
    Button {
        print("Swipe Trailing Action")
    } label: {
        Text("Edit")
            .background(Color.green)
    }
}

---

## 🛠 Toolbar Usage
####🔹 Single Toolbar Button

- Use when you only need one toolbar button, like a "+" or "Edit" button.
- Use `.toolbar` to add buttons to navigation bars, bottom toolbars, or even above the keyboard.

```swift
.toolbar {
    ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
            // Action
        }) {
            Image(systemName: "plus")
        }
    }
}

#### 🔹 Multiple Toolbar Buttons (Grouped)
 - Use ToolbarItemGroup when you want to display more than one item (like Edit + Delete).
 
.toolbar {
    ToolbarItemGroup(placement: .navigationBarTrailing) {
        Button {
            // Edit
        } label: {
            Image(systemName: "pencil")
        }

        Button(role: .destructive) {
            // Delete
        } label: {
            Image(systemName: "trash")
        }
    }
}

---

## 📍 Place a View at the Bottom of the Screen

Two common ways to place UI at the bottom of the screen in SwiftUI:

---

### 🧷 1. View That Follows the Keyboard (`.toolbar(.keyboard)`)

Use this when you want a **button or input field to appear only when the keyboard is open** — great for form submissions or chat apps.

```swift
@State private var itemName = ""

VStack {
    TextField("Enter item", text: $itemName)
        .textFieldStyle(.roundedBorder)
        .padding()
    
    Spacer()
}
.toolbar {
    ToolbarItemGroup(placement: .keyboard) {
        TextField("", text: $itemName)
        Button("Add") {
            print("Add button tapped")
        }
    }
}
```

🧠 .toolbar(.keyboard) automatically sticks above the keyboard and disappears when it's closed.


### 🛠️ 2. Persistent Bottom View (.safeAreaInset)
Use this when you want a **view to always stay at the bottom, regardless of whether the keyboard is open or not**

```swift
.safeAreaInset(edge: .bottom) {
    HStack {
        Text("Total: ₹399")
        Spacer()
        Button("Checkout") {
            // Perform checkout
        }
        .buttonStyle(.borderedProminent)
    }
    .padding()
    .background(.ultraThinMaterial)
}
```
✅ This stays in the safe area and won’t overlap with the home indicator or keyboard (unless manually adjusted).


---

## 🔁 State & Binding

### `@State`
```swift
@State private var name = ""
TextField("Enter name", text: $name)
```

### `@Binding`
```swift
struct ChildView: View {
    @Binding var count: Int
}
```

### `@Observable` (iOS 17+)
```swift
@Observable class MyViewModel {
    var counter: Int = 0
}
```

---
## 🟦 Empty State View
### ContentUnavailableView
##### Use when no results from server particularly for showing list
 ```swift
ContentUnavailableView {
    Label("No Tasks", systemImage: "tray")
} description: {
    Text("You haven't added any tasks yet.")
} actions: {
    Button("Add Task") {
        // your action here
    }
}
}
```


---

## 🧩 View Modifiers
```swift
.padding()
.background(Color.gray)
.cornerRadius(8)
.shadow(radius: 4)
.foregroundColor(.blue)
.font(.title)
```

---

## 📦 MVVM Pattern

### Model
```swift
struct Task: Identifiable {
    let id = UUID()
    var title: String
}
```

### ViewModel
```swift
@Observable class TaskViewModel {
    var tasks: [Task] = []
    func addTask(_ title: String) {
        tasks.append(Task(title: title))
    }
}
```

### View
```swift
struct ContentView: View {
    @State var model = TaskViewModel()
    var body: some View {
        List(model.tasks) { task in
            Text(task.title)
        }
    }
}
```

---

## 📋 Lists
```swift
List(items, id: \.id) { item in
    Text(item.name)
}
List {
    Section(header: Text("Fruits")) {
        Text("Apple")
        Text("Banana")
    }
}
```

---

## 🪄 Buttons
```swift
Button("Tap me") {
    print("Tapped!")
}
Button {
    showAlert = true
} label: {
    Image(systemName: "plus")
}
```

---

## ⚠️ Alerts & Sheets

### Alert
```swift
.alert("Delete Item?", isPresented: $showAlert) {
    Button("Delete", role: .destructive) { deleteItem() }
}
```

### Sheet
```swift
.sheet(isPresented: $showSheet) {
    AddItemView()
}
```

---

## 🧰 ViewModifiers
```swift
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 3)
    }
}
extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
}
```

---

## 📌 Previews with SwiftData
- We can show the sample data to preview for testing purpose.
- One is for with data and other one is without data.
```swift
#Preview("List with Sample Data") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Wish.self, configurations: config)
    
    container.mainContext.insert(Wish(title: "Sample Wish 1"))
    container.mainContext.insert(Wish(title: "Sample Wish 2"))
    container.mainContext.insert(Wish(title: "Sample Wish 3"))
    container.mainContext.insert(Wish(title: "Sample Wish 4"))
    container.mainContext.insert(Wish(title: "Sample Wish 5"))
    container.mainContext.insert(Wish(title: "Sample Wish 6"))

    return ContentView()
        .modelContainer(container)
}


#Preview("Empty List", body: {
    
    ContentView()
    //in memory means use memory for storing data for temporary database particularly for Preview.
        .modelContainer(for: [Wish.self], inMemory: true)
})
```

---

## 📝 TextFields & Forms
```swift
Form {
    TextField("Username", text: $username)
    SecureField("Password", text: $password)
}
```

---

## 🔄 ForEach
```swift
ForEach(0..<5) { i in
    Text("Row \(i)")
}
```

---

## 🎨 Fonts & Colors
```swift
.font(.headline)
.fontWeight(.bold)
.foregroundColor(.secondary)
Color(.systemBackground)
```

---

## 💡 Tips

- Add common patterns you look up frequently
- Keep snippets short and searchable
- Update this file as you grow your SwiftUI knowledge
