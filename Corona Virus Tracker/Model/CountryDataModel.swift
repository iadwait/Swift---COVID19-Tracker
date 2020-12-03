//
//  CountryDataModel.swift
//  Corona Virus Tracker
//
//  Created by Adwait Barkale on 03/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation

struct CountryDataModel: Codable
{
    
    var updated: Int?
    var country: String? //Country Name
    var countryInfo:  countryInfo
    var cases: Int?
    var totalCases: Int?
    var deaths: Int?
    var totalDeaths: Int?
    var recovered: Int?
    var totalRecovered: Int?
    var active: Int?
    var critical: Int?
    var tests: Int?
    var population: Int?
    
}

struct countryInfo: Codable {
    
    var flag: String? //Country Flag Url
    
}

/*
 
 {
   "updated": 1606975591858,
   "country": "Afghanistan",
   "countryInfo": {
     "_id": 4,
     "iso2": "AF",
     "iso3": "AFG",
     "lat": 33,
     "long": 65,
     "flag": "https://disease.sh/assets/img/flags/af.png"
   },
   "cases": 46980,
   "todayCases": 0,
   "deaths": 1822,
   "todayDeaths": 0,
   "recovered": 37026,
   "todayRecovered": 0,
   "active": 8132,
   "critical": 93,
   "casesPerOneMillion": 1196,
   "deathsPerOneMillion": 46,
   "tests": 152108,
   "testsPerOneMillion": 3871,
   "population": 39292791,
   "continent": "Asia",
   "oneCasePerPeople": 836,
   "oneDeathPerPeople": 21566,
   "oneTestPerPeople": 258,
   "activePerOneMillion": 206.96,
   "recoveredPerOneMillion": 942.31,
   "criticalPerOneMillion": 2.37
 }
 
 */
