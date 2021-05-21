//
//  ValidationFunctions.swift
//  Market.kz
//
//  Created by admin on 4/21/21.
//

import Foundation

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func isValidPassword(_ password: String) -> Bool {
     var lowerCaseLetter: Bool = false
     var upperCaseLetter: Bool = false
     var digit: Bool = false
     var specialCharacter: Bool = false

     if password.count  >= 8 {
         for char in password.unicodeScalars {
             if !lowerCaseLetter {
                 lowerCaseLetter = CharacterSet.lowercaseLetters.contains(char)
             }
             if !upperCaseLetter {
                 upperCaseLetter = CharacterSet.uppercaseLetters.contains(char)
             }
             if !digit {
                 digit = CharacterSet.decimalDigits.contains(char)
             }
             if !specialCharacter {
                 specialCharacter = CharacterSet.punctuationCharacters.contains(char)
             }
         }
         if specialCharacter || (digit && lowerCaseLetter && upperCaseLetter) {
            
             return true
         }
         else {
             return false
         }
     }
     return false
 }


func containsOnlyLetters(input: String) -> Bool {
   for chr in input {
      if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
         return false
      }
   }
   return true
}
