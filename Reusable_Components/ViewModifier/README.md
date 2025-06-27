

# View Modifier


✅ When to Use ViewModifier vs View Extension

✅ What is ViewModifier in SwiftUI?
A ViewModifier is a way to encapsulate view styling or behavior logic that can be reused across different views. Applying a ViewModifier to a view results in a new version of that view with modified appearance or behavior.

🧩 1. Use a ViewModifier Struct When:

The modifier needs to manage or receive external state (like a @Binding or internal logic).
You want customization, parameterization, or reuse with dynamic behavior.
You're applying a more complex transformation to a view.
You want to reduce repetition by reusing the same modifier logic.

📝 Using ViewModifier With and Without Parameters
You can create a ViewModifier with or without initialization parameters depending on whether the modifier needs any external input (like @Binding, Bool, Color, etc.).

✅ With Parameters (Stateful or Configurable Modifier)

When your modifier needs input (like a flag or color, or Binding), define it with properties and pass them via an extension:

 ```swift
struct CardToolbar: ViewModifier {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var currentModal: ToolbarSelection?

    func body(content: Content) -> some View {
        content
        .toolbar {
            //Top Toolbar
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
            
            //Bottom Toolbar
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

Combine with a View extension for a clean API (.myCustomStyle()).

extension View {
    func cardToolbar(currentModal: Binding<ToolbarSelection?>) -> some View {
        self.modifier(CardToolbar(currentModal: currentModal))
    }
}

We can preview the modifier like this.
#Preview {
  Color.yellow
    .modifier(CardToolbar(currentModal: .constant(nil)))
}
```


✅ Without Parameters (Stateless Modifier)

When your modifier doesn’t require any external data, you can define it without any parameters:

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

Refer Cards Project if you have doubt.
- [Reference Project](Cards/)


🧾 2. Use a View Extension Method (No Struct) When:

The modifier is simple and stateless.
You don’t need external state or parameters.
You just want to make code more readable and expressive.


 ```swift
extension View {
    func titleStyle() -> some View {
        self
            .font(.title)
            .foregroundColor(.blue)
    }
}
```
Usage:

 ```swift
Text("Welcome")
    .titleStyle()

```

