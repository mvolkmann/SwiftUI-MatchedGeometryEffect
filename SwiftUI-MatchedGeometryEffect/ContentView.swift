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
    
    func foodList(_ foods: [Food], selected: Bool) -> some View {
        List {
            ForEach(foods) { food in
                if food.selected == selected {
                    Text(food.name)
                        .matchedGeometryEffect(id: food.id, in: foodNS)
                        .onTapGesture {
                            withAnimation { toggle(food: food) }
                        }
                }
            }
        }
    }
    
    func toggle(food: Food) {
        let index = foods.firstIndex(where: { $0.id == food.id })!
        foods[index].selected.toggle()
    }
    
    var body: some View {
        HStack {
            VStack {
                Text("Available")
                foodList(foods, selected: false)
            }
            VStack {
                Text("Selected")
                foodList(foods, selected: true)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
