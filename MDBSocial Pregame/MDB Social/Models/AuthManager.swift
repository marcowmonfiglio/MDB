//
//  AuthManager.swift
//  MDB Social
//
//  Created by Michael Lin on 10/9/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore //Adds to authentication data storage

class AuthManager {
    
    static let shared = AuthManager() //singleton
    
    let auth = Auth.auth() //singleton for firebase auth
    
    enum SignInErrors: Error {
        case wrongPassword
        case userNotFound
        case invalidEmail
        case internalError
        case errorFetchingUserDoc
        case errorDecodingUserDoc
        case unspecified
    }
    
    let db = Firestore.firestore()
    
    var currentUser: User?
    
    private var userListener: ListenerRegistration?
    
    init() {
        guard let user = auth.currentUser else { return }
        
        linkUser(withuid: user.uid, completion: nil)
    }
    
    func signIn(withEmail email: String, password: String,
                completion: ((Result<User, SignInErrors>)->Void)?) { //Better versino of URLSession.shared.dataTask
        
        auth.signIn(withEmail: email, password: password, completion: { authResult, error in
            if let error = error { //Decode or parse error to assign it to the correct sign in error
                let nsError = error as NSError
                let errorCode = FirebaseAuth.AuthErrorCode(rawValue: nsError.code)
                switch errorCode {
                case .wrongPassword:
                    completion?(.failure(.wrongPassword))
                case .userNotFound:
                    completion?(.failure(.userNotFound))
                    
                /*
                 
                 */
                default:
                    completion?(.failure(.unspecified))
                }
                return //Remember to return with if-let
            }
            
            guard let authResult = authResult else {
                completion?(.failure(.internalError))
                return
            }
            
            self.linkUser(withuid: authResult.user.uid, completion: completion) //same completion as sign in
            //call link user
            
        })
        
        //Sign in function here needs to interact with firebase sign in function and parse users, errors, etc
        //completion(.success(User))
        //completion(.failure(SignInErrors))
        //Result: completion(.failure) or completion(.success) essentially
    }
    
    /* TODO: Firebase sign up handler, add user to firestore */
    
    func isSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signOut(completion: (()->Void)? = nil) {
        do {
            try auth.signOut()
            unlinkCurrentUser()
            completion?()
        } catch { }
    }
    
    private func linkUser(withuid uid: String,
                          completion: ((Result<User, SignInErrors>)->Void)?) {
        //First step was authentication, now we have uid, so link user parses it to get a user document from firestore firebase
        //access db which is the databse
        userListener = db.collection("users").document(uid).addSnapshotListener { docSnapshot, error in
            guard let document = docSnapshot else {
                completion?(.failure(.errorFetchingUserDoc))
                return
            }
            
            guard let user = try? document.data(as: User.self) else {
                completion?(.failure(.errorDecodingUserDoc))
                return
            }
                            
            self.currentUser = user
            completion?(.success(user))
        }
    }
    
    //User is a codable so it has a protocol
            
    
    //common error: doing collections manually, and messing up the keys will lead to denied requests; always use decodable API for user and events
            
    //create user struct from the firebase document; user is a codable object so it can decoded from json with swift api; because the struct keywords exactly match firebase, we can use the decodable api
    
// Need to allow for multiple user sessions; attach a 'listener' to a user; notifies all clients who have a listener on a document

    
    private func unlinkCurrentUser() {
        userListener?.remove()
        currentUser = nil
    }
}
