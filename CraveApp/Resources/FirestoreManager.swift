import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreManager {
    
    static let shared = FirestoreManager()
    
    private init() {}
    
    /// Database reference
    let db = FirebaseFirestore.Firestore.firestore()
}

// MARK: - Menu Item Functions

extension FirestoreManager {
    
    /// Fetches all menu items in `menu_items` collection. Returns a result object holding array of `MenuItem` if successful, error otherwise.
    /// - Parameter completion: Async closure to return result object holding array of `MenuItem` objects if fetch is successful, error otherwise.
    public func getAllMenuItems(completion: @escaping (Result<[MenuItem], Error>) -> Void) {
        let collectionRef = db.collection("menu_items")
        
        collectionRef.getDocuments(completion: { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(.failure(FirestoreErrors.failedToFetch))
                return
            }
            
            var result = [MenuItem]()
            
            for document in snapshot.documents {
                let dict = document.data()
                guard let name = dict["name"] as? String,
                      let price = dict["price"] as? Double,
                      let desc = dict["description"] as? String,
                      let imageUrl = dict["image_url"] as? String,
                      let categories = dict["categories"] as? [String] else {
                    completion(.failure(FirestoreErrors.failedToFetch))
                    return
                }
                
                let item = MenuItem(name: name,
                                    price: price,
                                    description: desc,
                                    imageUrl: imageUrl,
                                    categories: categories)
                
                result.append(item)
            }
            
            completion(.success(result))
        })
    }
    
    /// Fetches all menu items with tag in `categories` array matching `category`. Returns a result object holding an array of `MenuItem` if successful, error otherwise.
    /// - Parameter category: `Categories` object holding category filter to be applied to menu_items collection in DB.
    /// - Parameter completion: Async closure to return result object holding array of `MenuItem` objects if fetch is successful, error otherwise.
    public func getMenuItemsForCategory(category: Categories, completion: @escaping (Result<[MenuItem], Error>) -> Void) {
        let collectionRef = db.collection("menu_items")
        
        let query = collectionRef.whereField("categories", arrayContains: category.rawValue)
        
        query.getDocuments(completion: { snapshot, error in
            guard let snapshot = snapshot, error == nil else {
                completion(.failure(FirestoreErrors.failedToFetch))
                return
            }
            
            var result = [MenuItem]()
            
            for document in snapshot.documents {
                let dict = document.data()
                guard let name = dict["name"] as? String,
                      let price = dict["price"] as? Double,
                      let desc = dict["description"] as? String,
                      let imageUrl = dict["image_url"] as? String,
                      let categories = dict["categories"] as? [String] else {
                    completion(.failure(FirestoreErrors.failedToFetch))
                    return
                }
                
                let item = MenuItem(name: name,
                                    price: price,
                                    description: desc,
                                    imageUrl: imageUrl,
                                    categories: categories)
                
                result.append(item)
            }
            
            completion(.success(result))
        })
    }
}

//MARK: - Open Hours Functionn

extension FirestoreManager {
    
    /// Fetches all hours objects from DB, completion handler returns result object holding array of `Hours` objects if successful, error otherwise.
    /// - Parameter completion: Async closure to return result object holding array of `Hours` objects if successful, error if fetch fails.
    public func getOpenHours(completion: @escaping (Result<[Hours], Error>) -> Void) {
        let collectionRef = db.collection("hours")
        
        collectionRef.getDocuments(completion: { snapshot, error in
            guard let snapshot = snapshot,
                  error == nil else {
                completion(.failure(FirestoreErrors.failedToFetch))
                return
            }
            
            var result = [Hours]()
            
            for document in snapshot.documents {
                let dict = document.data()
                
                guard let day = dict["day"] as? String,
                      let open = dict["open"] as? String,
                      let close = dict["close"] as? String,
                      let isOpen = dict["is_open"] as? Bool else {
                    completion(.failure(FirestoreErrors.failedToFetch))
                    return
                }
                
                result.append(Hours(day: day, open: open, close: close, isOpen: isOpen, isToday: false))
            }
            
            completion(.success(result))
        })
    }
}
