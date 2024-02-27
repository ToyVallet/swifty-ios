import Foundation
import Alamofire
import Combine

class PasswordViewModel: ObservableObject{
    var subscription = Set<AnyCancellable>()
    
    @Published private var currentInput = ""
    
    func setCurrentInput(value: String) -> Void {
        currentInput = String(value.prefix(6))
    }
    func getCurrentInput() -> String {
        return currentInput
    }
    func getCurrentInput(index: Int) -> String {
        return currentInput.count > index ? String(currentInput[currentInput.index(currentInput.startIndex, offsetBy: index)]) : ""
    }
    func backspace() {
        currentInput = String(currentInput.dropLast())
    }
}
