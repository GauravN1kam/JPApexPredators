import SwiftUI
import MapKit

struct ContentView: View {
    
    let predators = Predators()
    @State var searchtext = ""
    @State var alphabetical: Bool = false
    @State var currentSelection = APType.all
    var filteredDinos: [ApexPredator] {
        predators.filter(by: currentSelection)
        predators.sort(by: alphabetical)
        return predators.search(for: searchtext)
    }
    var body: some View {
        NavigationStack{
            List(filteredDinos) { predator in
                NavigationLink {
                    PredatorDetails(predator: predator, position: .camera(
                        MapCamera(
                            centerCoordinate: predator.location,
                            distance: 30000)))
                } label: {
                    HStack {
                        //Dinasour Image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white , radius: 1)
                        
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 13)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                    
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $searchtext, prompt: "Search Dinasours")
            .autocorrectionDisabled()
            .animation(.default, value: searchtext)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect( .bounce , value: alphabetical)
                    }
                }
                
                ToolbarItem {
                    Menu {
                        Picker("Filter", selection: $currentSelection.animation()) {
                            ForEach(APType.allCases) { type in
                                Label(type.rawValue.capitalized, systemImage: type.icon)
                                
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
