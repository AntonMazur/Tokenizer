//
//  ViewController.swift
//  Tokenizer
//
//  Created by Anton Mazur on 08.01.2024.
//

import UIKit

final class MainViewController: UIViewController {
    private enum Language: Int {
        case english = 0
        case spanish = 1
    }
    
    @IBOutlet private var inputTextField: UITextField!
    @IBOutlet private var languageSegmentedControl: UISegmentedControl!
    @IBOutlet private var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, let range = Range(range, in: text) else { return true }
        let updatedText = text.replacingCharacters(in: range, with: string)
        let languageIndex = languageSegmentedControl.selectedSegmentIndex
        let tokenizedText = tokenize(updatedText, for: languageIndex)
        resultLabel.text = tokenizedText
        
        return true
    }
    
    private func tokenize(_ text: String, for languageIndex: Int) -> String? {
        guard let language = Language(rawValue: languageIndex) else { return nil }
        let separators: [String] = language == .english ? ["if", "and"] : ["si", "y"]
        let separatedText = separate(text: text, with: separators)
        
        return separatedText
    }

    private func separate(text: String, with separators: [String]) -> String {
        var text = text
        separators.forEach { separator in
            let separator = " \(separator) "
            text = text.replacingOccurrences(of: separator, with: "\n\(separator)", options: .caseInsensitive)
        }
        
        return text
    }
}
