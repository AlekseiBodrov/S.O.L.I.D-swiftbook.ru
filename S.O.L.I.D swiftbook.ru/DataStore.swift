import Foundation

final class DataStore {

    func savenameInCache(name: String) {
        print("Your name: \(name) is saved")
    }

    func getNameFromCache() -> String {
        return "some name"
    }
}
