import Foundation

//class UserDefaultsManager{
//    enum Key: String, CaseIterable{
//        case username, refreshToken, accessToken
//    }
//    
//    static let shared: UserDefaultsManager = {
//        return UserDefaultsManager()
//    }()
//    
//    func clearAll(){
////        print("UDM clearAll()")
//        let defaults = UserDefaults.standard
//        defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject(forKey:))
//    }
//    
//    func setTokens(username: String, accessToken: String, refreshToken: String){
////        print("UDM setTokens()")
//        UserDefaults.standard.set(username, forKey: Key.username.rawValue)
//        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
//        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
//        UserDefaults.standard.synchronize()
//    }
//    
//    func setTokens(accessToken: String, refreshToken: String){
////        print("UDM setTokens() without username")
//        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
//        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
//        UserDefaults.standard.synchronize()
//    }
//    
//    func getTokens()->Token{
//        let username = UserDefaults.standard.string(forKey: Key.username.rawValue)
//        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue)
//        let refreshToken = UserDefaults.standard.string(forKey: Key.refreshToken.rawValue)
//        return Token(username: username, accessToken: accessToken, refreshToken: refreshToken)
//    }
//}
