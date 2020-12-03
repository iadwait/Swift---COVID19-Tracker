//
//  TrackCountriesViewController.swift
//  Corona Virus Tracker
//
//  Created by Adwait Barkale on 03/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class TrackCountriesViewController: UIViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableCountryData: UITableView!
    
    let countryDataUrl = "https://corona.lmao.ninja/v2/countries/"
    var arrCountryData : [CountryDataModel] = []
    var isDataReceived = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableCountryData.delegate = self
        tableCountryData.dataSource = self
        tableCountryData.backgroundColor = .clear
        
        CountryDataHelper().sendRequest(url: countryDataUrl) { (data, success) in
            
            if success{
                let countryData = data as! [CountryDataModel]
                print(countryData.count)
                
                if countryData.count > 0 {
                    self.arrCountryData = countryData
                    self.isDataReceived = true
                    print("Country Data Received Success")
                    DispatchQueue.main.async {
                        self.tableCountryData.reloadData()
                    }
                }else{
                    print("Countries Received Success with Count 0")
                    self.isDataReceived = false
                }
                
            }else{
                print("Failed Receiving Country Data")
                self.isDataReceived = false
            }
            
        }
        
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
}

extension TrackCountriesViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDataReceived{
            return arrCountryData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCountryData.dequeueReusableCell(withIdentifier: "CountryDataViewCell") as! CountryDataViewCell
        cell.backgroundColor = .clear
        cell.lblCountryName.text = arrCountryData[indexPath.row].country
        cell.imgCountryFlag.setCustomImage(arrCountryData[indexPath.row].countryInfo.flag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
}
