//
//  CurrentLocation.swift
//  Weather App
//
//  Created by Nuveda on 04/07/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation?
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }
    
    func requestLocationPermission() {
        print("Requesting location permission")
        DispatchQueue.main.async {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("Location access denied or restricted")
        case .notDetermined:
            requestLocationPermission()
        @unknown default:
            fatalError("New case added to CLAuthorizationStatus that we need to handle")
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        print("Authorization status changed to: \(authorizationStatus.rawValue)")
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        print("Location updated: \(String(describing: currentLocation))")
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager Error: \(error.localizedDescription)")
        if let clError = error as? CLError {
            switch clError.code {
            case .denied:
                print("Location access denied by user")
            case .locationUnknown:
                print("Location unknown")
            default:
                print("Other Core Location error")
            }
        }
    }
}
