//
//  GlobalStateHelper.swift
//  Corona Virus Tracker
//
//  Created by Adwait Barkale on 03/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation


class GlobalStateHelper
{
    public func sendRequest(url: String,completion:@escaping(_ response:Any,_ success:Bool)->Void)
    {
        NetworkManager.shared.performRequest(with: url) { (safeData, success) in
            
            if success{
                do{
                    let objData = try JSONDecoder().decode(coronaStatus.self, from: safeData as! Data)
                    print("Decoding Successful for Global State Data")
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

/*
 
 public func sendRequest(url: String,completion:@escaping(_ response:Array<Any>,_ success:Bool)->Void)
      {
        var arrDataModel:[DataModel] = []
        NetworkManager.shared.performGetRequest(with: url) { (data, success) in
            if success{
                //Bind Data from Json to Swift Object
                do{
                    let objData = try JSONDecoder().decode([DataModel].self, from: data as! Data)
                    print("Decoding Success URL Session")
                    arrDataModel = objData
                    completion(arrDataModel,true)
                }catch{
                    print("Error Decoding URL Session")
                    completion([],false)
                }
            }else{
                completion([],false)
            }
        }
 
 */
