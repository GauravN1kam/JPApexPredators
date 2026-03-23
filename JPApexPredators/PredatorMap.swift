import SwiftUI
import MapKit

struct PredatorMap: View {
    let predators = Predators()
    @State var satelight: Bool = false
    @State var position: MapCameraPosition
    var body: some View {
        Map(position: $position) {
            ForEach(predators.allApexPredators) { predators in
                Annotation(predators.name, coordinate: predators.location) {
                    Image(predators.image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .shadow(color: .white, radius: 3)
                        .scaleEffect(x: -1)
                }
            }
        }
        .mapStyle(satelight ? .imagery(elevation: .realistic) : .standard(elevation: .realistic))
        .overlay(alignment: .bottomTrailing) {
            Button {
                satelight.toggle()
            } label : {
                Image(systemName: satelight ? "globe.americas.fill" : "globe.americas")
                    .font(.largeTitle)
                    .imageScale(.large)
                    .padding(3)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadius: 7))
                    .shadow(radius: 3)
                    .padding()
            }
        }
    }
}


#Preview {
    PredatorMap(position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[2].location,
                                            distance: 1000,
                                            heading: 250,
                                            pitch: 80))
    )
    .preferredColorScheme(.dark)
}
