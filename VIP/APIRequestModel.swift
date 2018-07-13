
//
//  APIRequestModel.swift
//  VIP
//
//  Created by Isidro Arzate on 7/12/18.
//  Copyright © 2018 Isidro Arzate. All rights reserved.
//

import Foundation
class APIRequestModel{
    static func getStandings(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        //        set the URL from where we are grabbing the tasks
        let url = URL(string: "https://worldcup.sfg.io/teams/results")
        //        instatiate a web session
        let session = URLSession.shared
        //        make the request
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
}
