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
- [💡 Tips](#-tips)

---

## 🧭 Navigation

### `NavigationStack`
```swift
NavigationStack {
    List(items) { item in
        NavigationLink(item.title, value: item)
    }
    .navigationDestination(for: Item.self) { item in
        DetailView(item: item)
    }
    .navigationTitle("Items")
}
```

### `NavigationLink` (direct)
```swift
NavigationLink("Go to Details", destination: DetailView())
```

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
