import Foundation
import Alamofire
import Combine

class WebViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
    var url = "https://"
}
