//
//  Row.swift
//  TaskSample
//
//  Created by Praveen Reddy on 03/05/20.
//  Copyright © 2020 Praveen Reddy. All rights reserved.
//

import UIKit
import SwiftyJSON


class Row : NSObject, NSCoding{

    var descriptionString : String!
    var imageHref : String!
    var titleString : String!

    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        descriptionString = json["description"].stringValue
        imageHref = json["imageHref"].string
        titleString = json["title"].stringValue
    }

    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if descriptionString != nil{
            dictionary["description"] = descriptionString
        }
        if imageHref != nil{
            dictionary["imageHref"] = imageHref
        }
        if titleString != nil{
            dictionary["title"] = titleString
        }
        return dictionary
    }


    @objc required init(coder aDecoder: NSCoder)
    {
        descriptionString = aDecoder.decodeObject(forKey: "description") as? String
        imageHref = aDecoder.decodeObject(forKey: "imageHref") as? String
        titleString = aDecoder.decodeObject(forKey: "title") as? String
    }


    func encode(with aCoder: NSCoder)
    {
        if descriptionString != nil{
            aCoder.encode(descriptionString, forKey: "description")
        }
        if imageHref != nil{
            aCoder.encode(imageHref, forKey: "imageHref")
        }
        if titleString != nil{
            aCoder.encode(titleString, forKey: "title")
        }

    }

}
