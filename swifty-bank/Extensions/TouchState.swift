enum TouchState {
    case none, began, moved, ended
    var name: String {
        return "\(self)"
    }
}
