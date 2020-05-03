//
//  Country.swift
//  TaskSample
//
//  Created by Praveen Reddy on 03/05/20.
//  Copyright © 2020 Praveen Reddy. All rights reserved.
//

import UIKit
import SwiftyJSON


class Country : NSObject, NSCoding{

    var rows : [Row]!
    var titleString : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        rows = [Row]()
        let rowsArray = json["rows"].arrayValue
        for rowsJson in rowsArray{
            let value = Row(fromJson: rowsJson)
            rows.append(value)
        }
                
        titleString = json["title"].stringValue
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if rows != nil{
        var dictionaryElements = [[String:Any]]()
        for rowsElement in rows {
            dictionaryElements.append(rowsElement.toDictionary())
        }
        dictionary["rows"] = dictionaryElements
        }
        if titleString != nil{
            dictionary["title"] = titleString
        }
        return dictionary
    }

    @objc required init(coder aDecoder: NSCoder)
    {
        rows = aDecoder.decodeObject(forKey: "rows") as? [Row]
        titleString = aDecoder.decodeObject(forKey: "title") as? String
    }

    func encode(with aCoder: NSCoder)
    {
        if rows != nil{
            aCoder.encode(rows, forKey: "rows")
        }
        if titleString != nil{
            aCoder.encode(titleString, forKey: "title")
        }

    }

}

