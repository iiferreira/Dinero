//
//  MockProfileManager.swift
//  Dinero
//
//  Created by Iuri Ferreira on 11/08/23.
//

import Foundation

class MockProfileManager : ProfileManager {
    var profile : Profile?
    var error: NetworkError?
    
    override func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
        if error != nil {
            completion(.failure(error!))
            return
        }
        profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
        completion(.success(profile!))
    }
}
