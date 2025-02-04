//
//  ViewModel.swift
//  MoFoods
//
//  Created by Syed Ahmad  on 04/02/2025.
//
import Foundation

class ViewModel : ObservableObject {
    
    @Published var errorMessage = ""
    @Published var showError = false
    @Published var showLoader = false
    @Published var navigateNext = false
    
    func showAlert(message: String) {
        
        DispatchQueue.main.async {
            self.errorMessage = message
            self.showError = true
        }
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
