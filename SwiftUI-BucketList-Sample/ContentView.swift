//
//  ContentView.swift
//  SwiftUI-BucketList-Sample
//
//  Created by ekayaint on 29.10.2023.
//
import MapKit
import LocalAuthentication
import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

/**struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}*/

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    @State private var locations = [Location]()
    
    @State private var selectedPlace: Location?
    
    /**let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    
    ]
    */
    let users = [
        User(firstName: "n1", lastName: "s1"),
        User(firstName: "n3", lastName: "s3"),
        User(firstName: "n2", lastName: "s2")
    ].sorted()
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
        
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                } //: if
            }
        } else {
            // no biometrics
        } //: if
    }
    
    var body: some View {
        /**Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = getDocumentsDirectory().appendingPathComponent("message.txt")
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                    
                } catch {
                    print(error.localizedDescription)
                } //: do
                
            }*/
       /** NavigationStack {
            Map(coordinateRegion: $mapRegion,annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    NavigationLink {
                        Text(location.name)
                    } label: {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
                    }
                        
                         
                     
                } //: Map Ann
            } //: Map
            .navigationTitle("London Explorer")
        } //: Nav
        */
      /**  VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        } //: VStack
        .onAppear(perform: authenticate)*/
        ZStack{
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                        
                        Text(location.name)
                            .fixedSize()
                    } //: VStack
                    .onTapGesture {
                        selectedPlace = location
                    }
                }
            }
                .ignoresSafeArea()
            Circle()
                .fill(.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: mapRegion.center.latitude, longtitude: mapRegion.center.longitude)
                        locations.append(newLocation)
                    } label: {
                        Image(systemName: "plus")
                    } //: Button
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundStyle(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                    
                } //: HStack
            } //: VStack
        } //: ZStack
        .sheet(item: $selectedPlace) { place in
            EditView(location: place) { newLocation in
                if let index = locations.firstIndex(of: place) {
                    locations[index] = newLocation
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
