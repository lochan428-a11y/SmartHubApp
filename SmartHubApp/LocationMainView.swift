import SwiftUI
import MapKit

struct LocationMainView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 22.384, longitude: 114.189),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    let points = [
        Place(name: "IVE (Sha Tin Campus)", latitude: 22.3842, longitude: 114.1884),
        Place(name: "SHAPE Office", latitude: 22.3833, longitude: 114.1888),
        Place(name: "Canteen", latitude: 22.3845, longitude: 114.1899),
        Place(name: "Sports Hall", latitude: 22.3839, longitude: 114.1879),
        Place(name: "Library", latitude: 22.3837, longitude: 114.1894),
        Place(name: "Bus Stop (Sha Tin Wai)", latitude: 22.3827, longitude: 114.1900),
        Place(name: "Car Park", latitude: 22.3850, longitude: 114.1875)
    ]

    var body: some View {
        NavigationStack {
            Map(coordinateRegion: $region, annotationItems: points) { place in
                MapAnnotation(coordinate: place.coordinate) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                        Text(place.name).font(.caption)
                    }
                }
            }
            .frame(height: 400)
            .cornerRadius(10)
            .padding()

            List(points) { place in
                VStack(alignment: .leading) {
                    Text(place.name).bold()
                    Text("Lat: \(place.latitude, specifier: "%.4f"), Lng: \(place.longitude, specifier: "%.4f")")
                        .font(.caption).foregroundColor(.gray)
                }
            }
            .navigationTitle("📍 校園地圖")
        }
    }
}

struct Place: Identifiable {
    let id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
