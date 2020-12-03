//
//  ViewController.swift
//  Corona Virus Tracker
//
//  Created by Adwait Barkale on 03/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    
    @IBOutlet weak var tableGlobalState: UITableView!
    
    let globalStateUrl = "https://corona.lmao.ninja/v2/all/"
    
    var globalStateData: coronaStatus!
    var isDataReceived = false
    var arrData:[DataModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableGlobalState.delegate = self
        tableGlobalState.dataSource = self
        
        GlobalStateHelper().sendRequest(url: globalStateUrl) { (data, success) in
            
            if success{
                let objGlobalState = data as! coronaStatus
                print("Global State Data Received")
                print(objGlobalState)
                self.globalStateData = objGlobalState
                self.isDataReceived = true
                self.createDataModel(globalStateData: self.globalStateData)
                DispatchQueue.main.async {
                    self.tableGlobalState.reloadData()
                }
            }else{
                self.isDataReceived = false
            }
            
        
        }
    }
    
    func createDataModel(globalStateData: coronaStatus)
    {
        if let todayCases = globalStateData.todayCases{
                 let strTodayCases = String(todayCases)
                 arrData.append(DataModel(name: "Today Cases", value: strTodayCases))
        }
        
        if let updated = globalStateData.updated{
            let strUpdated = String(updated)
            arrData.append(DataModel(name: "Updated", value: strUpdated))
        }
        
        if let cases = globalStateData.cases{
            let strCases = String(cases)
            arrData.append(DataModel(name: "Cases", value: strCases))
        }
        
        if let deaths = globalStateData.deaths{
            let strDeaths = String(deaths)
            arrData.append(DataModel(name: "Deaths", value: strDeaths))
        }
        
        if let recovered = globalStateData.recovered{
            let strRecvered = String(recovered)
            arrData.append(DataModel(name: "Recovered", value: strRecvered))
        }
        
        if let totalRecovered = globalStateData.todayRecovered{
            let strTotalRecovered = String(totalRecovered)
            arrData.append(DataModel(name: "Total Recovered", value: strTotalRecovered))
        }
        
        if let active = globalStateData.active{
            let strActive = String(active)
            arrData.append(DataModel(name: "Active", value: strActive))
        }
        
        if let critical = globalStateData.critical{
            let strCritical = String(critical)
            arrData.append(DataModel(name: "Critical", value: strCritical))
        }
        
        if let tests = globalStateData.tests{
            let strTests = String(tests)
            arrData.append(DataModel(name: "Tests", value: strTests))
        }
        
        if let affectedCountries = globalStateData.affectedCountries{
            let strAffectedContries = String(affectedCountries)
            arrData.append(DataModel(name: "Affected Countries", value: strAffectedContries))
        }
    }
    
    @IBAction func btnTrackCountriesTapped(_ sender: UIButton) {
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "TrackCountriesViewController") as! TrackCountriesViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
        
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

extension ViewController : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDataReceived
        {
            return arrData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableGlobalState.dequeueReusableCell(withIdentifier: "GlobalStateViewCell") as! GlobalStateViewCell

        if isDataReceived{
            
            cell.lblLeftTitle.text = arrData[indexPath.row].name
            cell.lblRightValue.text = arrData[indexPath.row].value
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}
