//
//  LocalState.swift
//  Dinero
//
//  Created by Iuri Ferreira on 01/07/23.
//

import Foundation

public class LocalState {
    
    private enum Keys : String {
        case hasOnboarded
    }
    
    public static var hasOnboarded : Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
        }
    }
}

public class defaultUser {
    
    private enum UserD : String {
        case name
    }
    
    public static var username : String {
        get {
            return UserDefaults.standard.string(forKey: UserD.name.rawValue) ?? ""
        }
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: UserD.name.rawValue)
        }
    }
}
