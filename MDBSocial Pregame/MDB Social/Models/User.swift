//
//  SOCUser.swift
//  MDB Social
//
//  Created by Michael Lin on 10/9/21.
//

import Foundation
import FirebaseFirestoreSwift

typealias UserID = String

struct User: Codable {
    @DocumentID var uid: UserID?
    
    var username: String
    
    var email: String
    
    var fullname: String
    
    var savedEvents: [EventID]
}
