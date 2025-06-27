## Empty State View

✅ ContentUnavailableView — SwiftUI’s Built-In Empty State View (iOS 17+)

📌 What is it?

ContentUnavailableView is a built-in SwiftUI view introduced in iOS 17 to easily show an "empty state" screen when there's no data to display.

🧠 Why use it?

Instead of building your own empty state with VStack, icons, and labels, Apple gives you a clean, consistent way to display something like:

*🔍 "No search results"
*📭 "No emails"
*📋 "No tasks yet"
*🌐 "No internet connection"


✅ Basic Usage

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
Label: Title with icon
Description: Optional text
Actions: Optional button(s)


🧩 Real Example in an App

```swift
struct TaskListView: View {
    @Query var tasks: [Task]

    var body: some View {
        if tasks.isEmpty {
            ContentUnavailableView {
                Label("No Tasks", systemImage: "tray")
            } description: {
                Text("Add a task to get started.")
            }
        } else {
            List(tasks) { task in
                Text(task.title)
            }
        }
    }
}

}
```
