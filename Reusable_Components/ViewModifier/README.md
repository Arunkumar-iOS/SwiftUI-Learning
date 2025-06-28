# 🎨 View Modifier

### ✅ When to Use `ViewModifier` vs `View Extension`

#### 🧾 What is `ViewModifier` in SwiftUI?
- We can add **styling and behavior** (changing appearance or layout) to existing views.
- Applying a `ViewModifier` to a view results in a **new version of that view** with modified appearance or behavior.

---

### ✅ Use a `ViewModifier` when:
- 🔧 You want to **pass parameters**
- 🔄 You need **access to parent state**
- ♻️ You want to **reuse the same styling with dynamic behaviour**

## 📝 Using ViewModifier With or Without Parameters

#### ✅ With Parameters (Stateful or Configurable Modifier)

```swift
struct CardToolbar: ViewModifier {
    @Environment(\.dismiss) var dismiss
    @Binding var currentModal: ToolbarSelection?

    func body(content: Content) -> some View {
        content
        .toolbar {
            // Top Toolbar
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }

            // Bottom Toolbar
            ToolbarItem(placement: .bottomBar) {
                BottomToolbar(modal: $currentModal)
            }
        }
        .sheet(item: $currentModal) { item in
            switch item {
            default:
                Text(String(describing: item))
            }
        }
    }
}

extension View {
    func cardToolbar(currentModal: Binding<ToolbarSelection?>) -> some View {
        self.modifier(CardToolbar(currentModal: currentModal))
    }
}

// ✅ Preview
#Preview {
    Color.yellow
        .modifier(CardToolbar(currentModal: .constant(nil)))
}
```

---

#### ✅ Without Parameters (Stateless Modifier)

When your modifier doesn’t require any external data, you can define it like this:

```swift
struct TitleStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(TitleStyleModifier())
    }
}
```

---

### 🧾 Use a View Extension Method (No Struct) When:

- 🎯 The styling is **simple**
- ❌ You don't need **external state or customization**

```swift
extension View {
    func titleStyle() -> some View {
        self
            .font(.title)
            .foregroundColor(.blue)
    }
}
```

✅ Usage:

```swift
Text("Welcome")
    .titleStyle()
```

---

📂 Refer Cards Project for real usage  
🔗 [Reference Project](../../Cards/)
