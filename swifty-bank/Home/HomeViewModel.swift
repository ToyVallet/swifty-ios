import Foundation
import Alamofire
import Combine

class HomeViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
}
