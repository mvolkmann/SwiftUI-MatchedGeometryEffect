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
    
    func foodList(selected: Bool) -> some View {
        List {
            ForEach(foods) { food in
                let use = food.selected == selected
                if use {
                    Text(food.name)
                        .matchedGeometryEffect(
                            id: food.id,
                            in: foodNS
                            /*
                            //TODO: Does this prevent smooth transitions?
                            //TODO: Without this the text sometimes disappears.
                            isSource: false
                            */
                            //isSource: !use
                        )
                        .onTapGesture {
                            withAnimation { toggle(food: food) }
                        }
                }
            }
        }.onAppear {
            print("foodList rendered")
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
                foodList(selected: false)
            }
            VStack {
                Text("Selected")
                foodList(selected: true)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
