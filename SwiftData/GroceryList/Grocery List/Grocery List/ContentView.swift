//
//  ContentView.swift
//  Grocery List
//
//  Created by Arunkumar on 28/06/25.
//

import SwiftUI
import SwiftData
import TipKit

struct ContentView: View {
    
    //Manual data for SwiftData
    func addEssentialFoods() {
        modelContext.insert(Item(title: "Bakery &  Bread", isCompleted: false))
        modelContext.insert(Item(title: "Meat & Seafood", isCompleted: true))
        modelContext.insert(Item(title: "Cereals", isCompleted: .random()))
        modelContext.insert(Item(title: "Pasta & Rice", isCompleted: .random()))
        modelContext.insert(Item(title: "Cheese & Eggs", isCompleted: .random()))
    }
    
    
    let buttonTip = AddButtonTip()
    
    init() {
        try? Tips.configure()
    }
    
    //In SwiftData, the @Environment(\.modelContext) property wrapper is used to access the ancestor's environment value — specifically, the ModelContext passed down from a ModelContainer.
    @Environment(\.modelContext) var modelContext
    
    // ModelContext is used to create a connection between view and container.So it can update, save and delete.
    
    
    //This Macro will query the model from container. it observes the model whenever the changes there it will update immediately also it very fast.
    @Query private var items: [Item]
    
    @State private var itemName: String = ""
    
    @FocusState private var isFocused: Bool = false
    
    
    var swipeLeftButton: some View {
        Button {
            print("Swipe Trailing Action")
        } label: {
            Text("Edit")
                .background(Color.green)
        }
    }
    
    func swipeRightDeleteButton(for item: Item) -> some View {
        Button(role: .destructive) {
            withAnimation {
                modelContext.delete(item)
            }
        } label: {
            Text("Delete")
                .frame(maxWidth: .infinity) // this below line makes text stretch to the full width.
        }
    }
        
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text(item.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .foregroundStyle(item.isCompleted == false ? Color.primary : Color.accentColor)
                        .strikethrough(item.isCompleted)
                        .italic(item.isCompleted)
                        .swipeActions {
                            Button(role: .destructive) {
                                withAnimation {
                                    modelContext.delete(item)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button("Done", systemImage: item.isCompleted == false ?  "checkmark.circle" : "x.circle") {
                                item.isCompleted.toggle()
                            }
                            .tint(item.isCompleted == false ? .green : .accentColor)
                        }
                }
            }
            .navigationTitle("Grocery List")
            .toolbar {
                if items.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addEssentialFoods()
                        } label: {
                            Image(systemName: "carrot")
                        }
                        .popoverTip(buttonTip)
                    }
                }
            }
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView("Empty Cart", systemImage: "cart.circle", description: Text("Add some items to the shopping list."))
                }
            }
            //If you want stick the view bottom of the screen without affection safe area, we can use this also if you want view to be stick in keyboard use .tool bar modifier.
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 12) {
                    TextField("", text: itemName)
                        .textFieldStyle(.plain)
                        .padding(12)
                        .background(.tertiary)
                        .cornerRadius(12)
                        .font(.title.weight(.light))
                        .focused($isFocused)
                    
                    Button {
                        guard !item.isEmpty else {
                            return
                        }
                        
                        let newItem = Item(title: item, isCompleted: false)
                        modelContext.insert(newItem)
                        item = ""
                        isFocused = false
                    } label: {
                        Text("Save")
                            .font(.title2.weight(.medium))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle)
                    .controlSize(.extraLarge)
                }
                .padding()
                .background(.bar)
            }
        }
        
    }
    
    private var topToolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                addEssentialFoods()
            } label: {
                Image(systemName: "carrot")
                    .padding(.trailing, 10)
            }
            .popoverTip(buttonTip)
        }
    }
    
    private var bottomInputView: some View {
        //If you want stick the view bottom of the screen without affection safe area, we can use this also if you want view to be stick in keyboard use .tool bar modifier.
        VStack(spacing: 10) {
            TextField("", text: $itemName)
                .textFieldStyle(.plain)
            //If you set padding before the background it works like ContentEdgeInsets. means give space around views.
                .padding(12)
                .background(.tertiary)
                .font(.title)
                .cornerRadius(10)
            
            Button {
                if itemName.isEmpty { return }
                modelContext.insert(Item(title: itemName, isCompleted: false))
                itemName = ""
            } label: {
                Text("Save")
                    .font(.title2.weight(.medium))
                    .frame(maxWidth: .infinity)
            }
            //If you want to customise the button add these
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
            .controlSize(.extraLarge)
        }
        .padding()
        //It gives a default bar background color.
        .background(.bar)
    }
}


/*
#Preview("With Sample Data") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Item.self, configurations: config)

    let items = [
        Item(title: "Milk", isCompleted: false),
        Item(title: "Eggs", isCompleted: true)
    ]
    
    for item in items {
        container.mainContext.insert(item)
    }

    ContentView() // ✅ No return keyword
        .modelContainer(container)
}

 */


#Preview("Empty List", body: {
    
    ContentView()
    //in memory means use memory for storing data for temporary database particularly for Preview.
        .modelContainer(for: [Item.self], inMemory: true)
})
