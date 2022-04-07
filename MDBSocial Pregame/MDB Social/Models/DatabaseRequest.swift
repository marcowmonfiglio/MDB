//
//  SOCDBRequest.swift
//  MDB Social
//
//  Created by Michael Lin on 10/9/21.
//

import Foundation
import FirebaseFirestore //Calls firebase firestore to add additional data that is not authentication data

class DatabaseRequest {
    
    static let shared = DatabaseRequest()
    
    let db = Firestore.firestore()
    
    func setUser(_ user: User, completion: (()->Void)?) {
        /* TODO: Hackshop */
    }
    
    func setEvent(_ event: Event, completion: (()->Void)?) {
        /* TODO: Hackshop */
    }
    
    /* TODO: Events getter */
}
