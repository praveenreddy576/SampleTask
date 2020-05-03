//
//  CountryAPI.swift
//  TaskSample
//
//  Created by Praveen Reddy on 03/05/20.
//  Copyright © 2020 Praveen Reddy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class CountryAPI: NSObject {
    
    
   private let URL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
      
      func fetch(completion: @escaping (_ country: Country?, _ error: Error?) -> ()) {
          AF.request(URL, method: .get).responseString { response in
              switch response.result {
              case .success(let value):
                  let country = Country(fromJson: JSON(parseJSON: value))
                  completion(country, nil)
              case .failure(let error):
                  completion(nil, error)
              }
          }
      }
    
    

}
