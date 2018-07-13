//
//  TeamDetailViewController.swift
//  VIP
//
//  Created by Isidro Arzate on 7/13/18.
//  Copyright © 2018 Isidro Arzate. All rights reserved.
//

import Foundation
protocol TeamDetailViewControllerDelegate:class {
    func addTeam(by controller: TeamDetailViewController, with team: NSDictionary)
}
