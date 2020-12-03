//
//  NetworkManager.swift
//  Corona Virus Tracker
//
//  Created by Adwait Barkale on 03/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation


class NetworkManager
{
    
    static let shared = NetworkManager()
    
    func performRequest(with url: String,completion:@escaping(_ response:Any,_ success:Bool)->Void )
    {
        if let Url = URL(string: url)
        {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: Url) { (data, response, error) in
                if error != nil
                {
                    print("Error Hitting Api - \(url)")
                }else{
                    //Parse Data
                   if let safeData = data
                   {
                        completion(safeData,true)
                   }else{
                    print("No Data Received from - \(url)")
                    completion([],false)
                    return
                    }
                }
            }
            task.resume()
        }
        
        
        
    }
    
}
