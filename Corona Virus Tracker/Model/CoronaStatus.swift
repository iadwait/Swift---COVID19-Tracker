//
//  CoronaStatus.swift
//  Corona Virus Tracker
//
//  Created by Adwait Barkale on 03/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import Foundation


class coronaStatus: Codable{
    
    var updated : Int?
    var cases : Int?
    var todayCases : Int?
    var deaths : Int?
    var recovered : Int?
    var todayRecovered : Int?
    var active : Int?
    var critical : Int?
    var tests : Int?
    var affectedCountries : Int?

}

/*
{
  "updated": 1606970191425,
  "cases": 64844711,
  "todayCases": 21330,
  "deaths": 1499346,
  "todayDeaths": 979,
  "recovered": 44941481,
  "todayRecovered": 14408,
  "active": 18403884,
  "critical": 106672,
  "casesPerOneMillion": 8319,
  "deathsPerOneMillion": 192.4,
  "tests": 1024288656,
  "testsPerOneMillion": 131466.82,
  "population": 7791233113,
  "oneCasePerPeople": 0,
  "oneDeathPerPeople": 0,
  "oneTestPerPeople": 0,
  "activePerOneMillion": 2362.13,
  "recoveredPerOneMillion": 5768.21,
  "criticalPerOneMillion": 13.69,
  "affectedCountries": 220
}
*/
