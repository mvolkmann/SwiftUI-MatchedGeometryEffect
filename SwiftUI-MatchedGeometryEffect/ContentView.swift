import SwiftUI

struct Food: Identifiable {
    var name: String
    var selected: Bool = false
    var id: String { name }
}

struct ContentView: View {
    @Namespace private var foodNS
    
    @State var foods: [Food] = [
        Food(name: "Hamburger"),
        Food(name: "Fries"),
        Food(name: "Shake"),
    ]
    
    func toggle(food: Food) {
        let index = foods.firstIndex(where: { $0.id == food.id })!
        foods[index].selected.toggle()
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("Available")
                List {
                    ForEach(foods) { food in
                        if !food.selected {
                            Text(food.name)
                                .matchedGeometryEffect(id: food.name, in: foodNS)
                                .onTapGesture {
                                    withAnimation { toggle(food: food) }
                                }
                        }
                    }
                }
            }
            VStack {
                Text("Selected")
                List {
                    ForEach(foods) { food in
                        if food.selected {
                            Text(food.name)
                                .matchedGeometryEffect(id: food.name, in: foodNS)
                                .onTapGesture {
                                    withAnimation { toggle(food: food) }
                                }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
