//
//  AuthManager.swift
//  Market.kz
//
//  Created by admin on 4/21/21.
//

import Foundation

final class AuthManager{
    static let shared = AuthManager()
    
    struct Constants {
        static let AUTH_API_URL = "http://localhost:8080/api/auth/"
        
    }
    
    private init(){
        
    }
    
    public func signUp(fullname : String , email : String , password : String , completion : @escaping (Bool) -> Void){
        let url = URL(string: Constants.AUTH_API_URL + "signup")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        print(password)
        let parameters: [String: Any] = [
            "fullname": fullname,
            "email": email,
            "password": password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpBody = jsonData
     

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }

        task.resume()
    }
    
    
    
    public func signIn( email : String , password : String , completion : @escaping ((Result<AuthResponse , Error>) ) -> Void){
        let url = URL(string: Constants.AUTH_API_URL + "signin")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
     
        let parameters: [String: Any] = [
      
            "email": email,
            "password": password
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpBody = jsonData
     

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                completion(.failure(error as! Error))
                return
            }
            
        

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
            do{
                let result = try JSONDecoder().decode(AuthResponse.self, from : data)
                print("Result : \(result.fullname)" )
                self.cacheToken(result: result)
                
                
                completion(.success(result))
            }
            catch{
                print(error.localizedDescription)
                completion(.failure(error))
            }
               
        }

        task.resume()
    }
    public func cacheToken(result : AuthResponse){
        UserDefaults.standard.setValue(result.accessToken, forKey: "access_token")
        UserDefaults.standard.setValue(result.id, forKey: "current_user_id")
        UserDefaults.standard.setValue(result.email, forKey: "current_user_email")
//        if let _ = result.refresh_token{
//        UserDefaults.standard.setValue(result.refresh_token, forKey: "refresh_token")
//        }
//        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
    
}
