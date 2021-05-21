//
//  APICaller.swift
//  Market.kz
//
//  Created by admin on 5/6/21.
//

import Foundation
import UIKit
import Alamofire

final class APICaller{
    
    static let shared = APICaller()
    
    struct Constants {
        static let baseAPIURL = "http://localhost:8080/api/market/"
        
    }
    
    enum APIError : Error{
        case failedToGetData
        case failedToPostData
    }
    
    private init(){
        
    }
    
    
    
    public func getAdsImages( adsId : String  , completion : @escaping (Result<[ImageResponse] , Error>) -> Void){
 
        createNonAuthRequest(with: URL(string: Constants.baseAPIURL + "getImage/" + adsId),
                      type: .GET)
        { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest){data , _ , error in

                guard let data = data , error == nil else{
        
                    completion(.failure(error!))
                    return
                }
                
  
                do {
                    let resultAll = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                      print(resultAll)
                
                    let result = try JSONDecoder().decode([ImageResponse].self , from : data)
                  
                    print(result)
                
                    completion(.success(result))
                    
                } catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    
    }
    
    public func getAllAds(completion : @escaping (Result<[AdsResponse] , Error>) -> Void){
 
        createNonAuthRequest(with: URL(string: Constants.baseAPIURL + "allAds"),
                      type: .GET)
        { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest){data , _ , error in

                guard let data = data , error == nil else{
        
                    completion(.failure(error!))
                    return
                }
                
  
                do {
                      
                
                    let result = try JSONDecoder().decode([AdsResponse].self , from : data)
                  
                    print(result)
                
                    completion(.success(result))
                    
                } catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    
    }
    
    public func getAllAdsByAdsType(adsTypeIId : String , completion : @escaping (Result<[AdsResponse] , Error>) -> Void){
 
        createNonAuthRequest(with: URL(string: Constants.baseAPIURL + "allAdsByAdsTypeId/" + adsTypeIId),
                      type: .GET)
        { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest){data , _ , error in

                guard let data = data , error == nil else{
        
                    completion(.failure(error!))
                    return
                }
                
  
                do {
                      
                
                    let result = try JSONDecoder().decode([AdsResponse].self , from : data)
                  
                    print(result)
                
                    completion(.success(result))
                    
                } catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    
    }
    
    
    public func getAllAdsByUser(userId : String , completion : @escaping (Result<[AdsResponse] , Error>) -> Void){
 
        createNonAuthRequest(with: URL(string: Constants.baseAPIURL + "allAdsByUserId/" + userId),
                      type: .GET)
        { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest){data , _ , error in

                guard let data = data , error == nil else{
        
                    completion(.failure(error!))
                    return
                }
                
  
                do {
                      
                
                    let result = try JSONDecoder().decode([AdsResponse].self , from : data)
                  
                    print(result)
                
                    completion(.success(result))
                    
                } catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    
    }
    
    
    public func getAdsTypes(completion : @escaping (Result<[AdsTypeResponse], Error>) -> Void){
 
        createNonAuthRequest(with: URL(string: Constants.baseAPIURL + "allAdsTypes"),
                      type: .GET)
        { baseRequest in
            
            let task = URLSession.shared.dataTask(with: baseRequest){data , _ , error in

                guard let data = data , error == nil else{
        
                  completion(.failure(APIError.failedToGetData))
                    return
                }
                
  
                do {
              
                
                    let result = try JSONDecoder().decode([AdsTypeResponse].self , from : data)
                  
                    print(result)
                
                    completion(.success(result))
                    
                } catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    
    }
    
    
    public func deleteAd(adsId : String , completion : @escaping ((Result<String , Error>)) -> Void){
        let url = URL(string: Constants.baseAPIURL + "deleteAds/" + adsId)!
        var request = URLRequest(url: url)
        request.setValue("Bearer \( UserDefaults.standard.string(forKey: "access_token")!)" , forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
     

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                completion(.failure(error!))
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            completion(.success(responseString!))
        }

        task.resume()
    }
    
    public func uploadAds(name : String , address : String , city : String , description : String , price : String , wasInUse : Bool  ,category : AdsTypeResponse, userId : String , completion : @escaping ((Result<String , Error>)) -> Void){
        let url = URL(string: Constants.baseAPIURL + "addAds")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \( UserDefaults.standard.string(forKey: "access_token")!)" , forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

       
        
        
        let parameters: [String: Any] = [
            "name": name,
            "adress" : address,
            "city" : city,
            "description" : description,
            "price" : price,
            "isNew" : wasInUse,
            "adType" : [
                
                "id" : category.id
            
            ],
            "user" :  [
                
                "id" : userId
            
            ],
           
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        
        request.httpBody = jsonData
     

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                completion(.failure(error!))
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString!)")
            completion(.success(responseString!))
        }

        task.resume()
    }
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    

    
    func uploadImage(paramName: String, fileName: String, image: UIImage , adsId : String) {
        let url = URL(string: Constants.baseAPIURL + "addImages/" + adsId)

        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString

        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \( UserDefaults.standard.string(forKey: "access_token")!)" , forHTTPHeaderField: "Authorization")
        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
       
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }).resume()
    }
    
    enum HTTPMethod : String {
        case GET
        case POST
    }
    
    private func createNonAuthRequest(with url : URL? ,
                               type : HTTPMethod,
                               complition: @escaping (URLRequest)  -> Void) {
   
            guard let apiURL = url else {
                return
            }
            
            var request = URLRequest(url: apiURL)
            

            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            complition(request)

            
        
    
    }
    private func createRequest(with url : URL? ,
                               type : HTTPMethod,
                               complition: @escaping (URLRequest)  -> Void) {
   
            guard let apiURL = url else {
                return
            }
            
            var request = URLRequest(url: apiURL)
            
        request.setValue("Bearer \(String(describing: UserDefaults.standard.string(forKey: "access_token")))" , forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            complition(request)

            
        
    
    }
}
