//
//  CountryViewModel.swift
//  TaskSample
//
//  Created by Praveen Reddy on 03/05/20.
//  Copyright © 2020 Praveen Reddy. All rights reserved.
//

import UIKit
import SwiftyJSON

class CountryViewModel: NSObject {
    
    private let countryAPI = CountryAPI()
    private var country:Country?
    
    func fetchCountry(completion:@escaping() -> ()) {
        countryAPI.fetch { (country, error) in
            self.country = country
            completion()
        }
    }
    
    func titleForCountry() -> String {
        return country?.titleString ?? ""
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows() -> Int {
        guard let rows = country?.rows else {
            return 0
        }
        return rows.count
    }
    
    func rowForItemAtIndexPath(indexPath: IndexPath) -> Row {
        return country?.rows[indexPath.row] ?? Row(fromJson: JSON())
    }

}
