import Foundation

class DataStore {
    
    // Сохранение данных в кеш/базу данных
    func savenameInCache(name: String) {
        print("Your name: \(name) is saved")
    }
    
    // Получать данные из кеша/базы данных
    func getNameFromCache() -> String {
        return "some name"
    }
}
