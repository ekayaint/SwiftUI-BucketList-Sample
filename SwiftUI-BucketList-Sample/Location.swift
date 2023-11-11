//
//  Location.swift
//  SwiftUI-BucketList-Sample
//
//  Created by ekayaint on 5.11.2023.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longtitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longtitude)
    }
    static let example = Location(id: UUID(), name: "Buckingham", description: "Sample description", latitude: 51.501, longtitude: -0.141)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
