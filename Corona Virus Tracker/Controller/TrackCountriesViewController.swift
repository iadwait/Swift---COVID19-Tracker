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
    var tempCountryData : [CountryDataModel] = []
    var isDataReceived = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableCountryData.delegate = self
        //tableCountryData.dataSource = self
        txtSearch.delegate = self
        txtSearch.addTarget(self, action: #selector(searchChanged), for: .editingChanged)
        tableCountryData.backgroundColor = .clear
        txtSearch.attributedPlaceholder = NSAttributedString(string: "Search",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        CountryDataHelper().sendRequest(url: countryDataUrl) { (data, success) in
            
            if success{
                let countryData = data as! [CountryDataModel]
                print(countryData.count)
                
                if countryData.count > 0 {
                    self.arrCountryData = countryData
                    self.tempCountryData = self.arrCountryData
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func searchChanged()
    {
        //print("Called for \(txtSearch.text)")
        self.tempCountryData.removeAll()
        let search = txtSearch.text
        
        if search?.count == 0
        {
            
            self.tempCountryData = arrCountryData
            self.tableCountryData.reloadData()
            return
        }else{
            for i in 0..<arrCountryData.count{
                let data = arrCountryData[i].country
                let range = data?.lowercased().range(of: search!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil{
                    tempCountryData.append(arrCountryData[i])
                    //self.tempNewsData.articles.append(objNewsData.articles[search])
                    //flagDataFetched = true
                }
            }
            
            if tempCountryData.count == 0
            {
                self.tempCountryData = self.arrCountryData
            }
            self.tableCountryData.reloadData()
        }
        
    }
    
    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
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
            return tempCountryData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCountryData.dequeueReusableCell(withIdentifier: "CountryDataViewCell") as! CountryDataViewCell
        cell.backgroundColor = .clear
        cell.lblCountryName.text = tempCountryData[indexPath.row].country
        cell.imgCountryFlag.setCustomImage(tempCountryData[indexPath.row].countryInfo.flag)
        cell.btnCell.tag = indexPath.row
        cell.btnCell.addTarget(self, action: #selector(goToCountryDetailPage(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func goToCountryDetailPage(sender: UIButton)
    {
        let countryDetailVC = storyboard?.instantiateViewController(withIdentifier: "CountryDetailsViewController") as! CountryDetailsViewController
        countryDetailVC.countryData = tempCountryData[sender.tag]
        self.navigationController?.pushViewController(countryDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let countryDetailVC = storyboard?.instantiateViewController(withIdentifier: "CountryDetailsViewController") as! CountryDetailsViewController
        countryDetailVC.countryData = tempCountryData[indexPath.row]
        self.navigationController?.pushViewController(countryDetailVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
}

extension TrackCountriesViewController: UITextFieldDelegate
{
    
}


/*
 func updateTableData(searchText:String)
 {
 print(searchedText)
 //tempNewsData = emptyNewsData
 tempNewsData.articles.removeAll()
 //flagDataFetched = false
 let articlesCount = objNewsData.articles.count
 
 if articlesCount > 0{
 for search in 0..<articlesCount{
 let data = objNewsData.articles[search].title
 let range = data?.lowercased().range(of: searchText, options: .caseInsensitive, range: nil, locale: nil)
 if range != nil{
 self.tempNewsData.articles.append(objNewsData.articles[search])
 flagDataFetched = true
 }
 }
 }
 if tempNewsData.articles.count == 0{
 tempNewsData = objNewsData
 flagDataFetched = true
 }
 newsTable.reloadData()
 }
 */
