
import UIKit



class ViewController: UIViewController, UITextFieldDelegate {

    var dataFetcherService = DataFetcherService()
    let dataStore = DataStore()

    let screenSize = UIScreen.main.bounds

    lazy var textLable: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: screenSize.width / 2 - 100, y: 50, width: 200, height: 50)
        lable.font = .systemFont(ofSize: 36, weight: .thin)
        lable.text = "Enter name"
        lable.textColor = .white
        lable.textAlignment = .left
        lable.backgroundColor = .white.withAlphaComponent(0.1)
        return lable
    }()

    lazy var myTectField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: screenSize.width / 2 - 100, y: 150, width: 200, height: 50)
        textField.backgroundColor = .white.withAlphaComponent(0.1)
        textField.font = .systemFont(ofSize: 36, weight: .thin)
        textField.tintColor = .blue
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.keyboardType = .default
        textField.delegate = self
        return textField
    }()
    lazy var textLableSave: UILabel = {
        let lable = UILabel()
        lable.frame = CGRect(x: screenSize.width / 2 - 100, y: 220, width: 200, height: 50)
        lable.font = .systemFont(ofSize: 36, weight: .thin)
        lable.textColor = .white
        lable.textAlignment = .left
        lable.backgroundColor = .white.withAlphaComponent(0.1)
        return lable
    }()
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: screenSize.width / 2 - 100, y: 300, width: 200, height: 50)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0) , for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19, weight: .bold)
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(saveButtonTapped) , for: .touchUpInside)
        return button
    }()

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        dataFetcherService.fetchCountry { (countries) in
            print(countries?.first?.Name)
        }
        
        dataFetcherService.fetchFreeGames { (freeGames) in
            print(freeGames?.feed.results.first?.name)
        }
        
        dataFetcherService.fetchNewGames { (newGames) in
            print(newGames?.feed.results.first?.name)
        }
    
        [textLableSave,
         myTectField,
         textLable,
         saveButton].forEach {
            view.addSubview($0)
        }
    }

    // MARK: - Business logic

    func changeName() {
        guard let name = textLableSave.text, name != "" else {
            showAlert()
            return
        }
        
        dataStore.savenameInCache(name: name)
    }

    //MARK: - User interface

    func showAlert() {
        let alert = UIAlertController(title: "WARNING", message: "Your name can't be empty.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if let text = textField.text {
            if let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                textLableSave.text = updatedText
            }
        }
        return true
    }
    
    @objc func saveButtonTapped(_ sender: Any) {
        changeName()
    }
}
