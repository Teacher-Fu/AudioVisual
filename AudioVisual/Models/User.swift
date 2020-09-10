//
//  User.swift
//  AudioVisual
//
//  Created by winpower on 2020/7/30.
//  Copyright © 2020 yasuo. All rights reserved.
//

import Foundation
import ObjectMapper
import KeychainAccess
import MessageKit

private let userKey = "CurrentUserKey"
private let keychain = Keychain(service: Configs.App.bundleIdentifier)

enum UserType: String {
    case user = "User"
    case admin = "Admin"
}

struct User: Mappable, SenderType {
    
    var senderId: String { return login ?? "" }
    
    var displayName: String { return login ?? "" }
    
    mutating func mapping(map: Map) {
        
    }
    
    var phone: String? // The user's publicly visible profile phone.
    var email: String?  // The user's publicly visible profile email.
    var login: String?  // The username used to login.
    var name: String?  // The user's public profile name.
    var type: UserType = .user
    
    init?(map: Map) {}
    init() {}

}



extension User {
    
    func isMine() -> Bool {
        guard let currentUser = User.currentUser() else {
            return false
        }
        return self == currentUser
    }
    
    static func currentUser() -> User? {
        if let json = keychain[userKey], let user = User(JSONString: json) {
            return user
        }
        return nil
    }
    
    static func removeCurrentUser() {
        keychain[userKey] = nil
    }
    
}


extension User {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.login == rhs.login
    }
}
