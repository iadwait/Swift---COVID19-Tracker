//
//  CountryDataHelper.swift
//  Corona Virus Tracker
//
//  Created by Adwait Barkale on 03/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation

class CountryDataHelper
{
    public func sendRequest(url: String,completion:@escaping(_ response:Any,_ success:Bool)->Void)
    {
        NetworkManager.shared.performRequest(with: url) { (safeData, success) in
            
            if success{
                do{
                    let objData = try JSONDecoder().decode([CountryDataModel].self, from: safeData as! Data)
                    print("Decoding Successful for Country Data")
                    completion(objData,true)
                }catch let err{
                    print("Error - \(err.localizedDescription)")
                    completion([],false)
                }
            }else{
                completion([],false)
            }
            
        }
    }
    
}
