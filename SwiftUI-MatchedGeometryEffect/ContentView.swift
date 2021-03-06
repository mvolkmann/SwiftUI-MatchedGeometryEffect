import SwiftUI

//TODO: This isn't working correctly.
//TODO: The text views move from one List to another when clicked,
//TODO: but they don't animate smoothly from one to the other
//TODO: and the text often disappears after the move.

struct Food: Identifiable {
    // This cannot be changed after creating an instance
    // because it is used as the id.
    let name: String
    
    var selected: Bool = false
    
    var id: String { name }
}

class Foods: ObservableObject {
    @Published private(set) var items: [Food] = [
        Food(name: "Hamburger"),
        Food(name: "Fries"),
        Food(name: "Shake")
    ]
    
    func toggle(item: Food) {
        let index = items.firstIndex(where: { $0.id == item.id })!
        items[index].selected.toggle()
    }
}

struct FoodList: View {
    @ObservedObject var foods: Foods
    let namespace: Namespace.ID
    let selected: Bool
    
    var body: some View {
        List(foods.items) { item in
            let use = item.selected == selected
            if use {
                Text(item.name)
                    .matchedGeometryEffect(
                        id: item.id,
                        in: namespace
                        /*
                         //TODO: Does this prevent smooth transitions?
                         //TODO: Without this the text sometimes disappears.
                         isSource: false
                         */
                        //isSource: !use
                    )
                    .onTapGesture {
                        print("got tap")
                        withAnimation {
                            // This gives the error "Cannot use mutating member
                            // on immutable value.
                            //item.selected.toggle()
                            foods.toggle(item: item)
                        }
                    }
            }
        }
    }
}

struct ContentView: View {
    @Namespace private var foodNS
    @ObservedObject var foods = Foods()
    
    var body: some View {
        HStack {
            VStack {
                Text("Available")
                FoodList(foods: foods, namespace: foodNS, selected: false)
            }
            VStack {
                Text("Selected")
                FoodList(foods: foods, namespace: foodNS, selected: true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
