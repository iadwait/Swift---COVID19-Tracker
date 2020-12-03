//
//  CountryDetailsViewController.swift
//  Corona Virus Tracker
//
//  Created by Adwait Barkale on 03/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class CountryDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var countryData: CountryDataModel?
    var arrData: [DataModel] = []
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var tableCountryDetail: UITableView!
    @IBOutlet weak var tableCountryDetailHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = "Details of \(countryData?.country ?? "")"
        tableCountryDetail.delegate = self
        tableCountryDetail.dataSource = self
        createDataModel(countryDetails: countryData!)
        tableCountryDetailHeight.constant = CGFloat(65 * arrData.count)
        tableCountryDetail.reloadData()
    }
    
    func createDataModel(countryDetails: CountryDataModel)
    {
        if let countryName = countryDetails.country{
            //let strTodayCases = String(todayCases)
            arrData.append(DataModel(name: "Country Name", value: countryName))
        }
        
        if let cases = countryDetails.cases{
            let strCases = String(cases)
            arrData.append(DataModel(name: "Cases", value: strCases))
        }
        
        if let recovered = countryDetails.recovered{
            let strRecovered = String(recovered)
            arrData.append(DataModel(name: "Recovered", value: strRecovered))
        }
        
        if let death = countryDetails.deaths{
            let strDeath = String(death)
            arrData.append(DataModel(name: "Deaths", value: strDeath))
        }
        
        if let active = countryDetails.active{
            let strActive = String(active)
            arrData.append(DataModel(name: "Active", value: strActive))
        }
        
        if let todayCases = countryDetails.todayCases{
            let strTodayCases = String(todayCases)
            arrData.append(DataModel(name: "Today Cases", value: strTodayCases))
        }
        
        if let todayDeaths = countryDetails.todayDeaths{
            let strTodayDeaths = String(todayDeaths)
            arrData.append(DataModel(name: "Today Deaths", value: strTodayDeaths))
        }
        
        if let totalDeaths = countryDetails.totalDeaths{
            let strTotalDeaths = String(totalDeaths)
            arrData.append(DataModel(name: "Total Deaths", value: strTotalDeaths))
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCountryDetail.dequeueReusableCell(withIdentifier: "CountryDetailViewCell") as! CountryDetailViewCell
        cell.lblLeftTitle.text = arrData[indexPath.row].name
        cell.lblRightValue.text = arrData[indexPath.row].value
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}
