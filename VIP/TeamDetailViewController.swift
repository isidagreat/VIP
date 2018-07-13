//
//  TeamDetailViewController.swift
//  VIP
//
//  Created by Isidro Arzate on 7/12/18.
//  Copyright © 2018 Isidro Arzate. All rights reserved.
//

import UIKit

var items = [NSDictionary]()
class TeamDetailViewController: UIViewController {
    weak var delegate: TeamDetailViewControllerDelegate?
    var teamDict: NSDictionary?

    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var goalLabel: UILabel!
    
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var divisionLabel: UILabel!

    @IBOutlet weak var detailTableviewController: UITableView!
    override func viewDidLoad() {
        detailTableviewController.delegate = self
        detailTableviewController.dataSource = self
        winLabel.text = "Points: \(teamDict?["points"]! ?? "n/a")"
        goalLabel.text = "All Goals: \(teamDict?["goals_for"]! ?? "n/a")"
        super.viewDidLoad()
//        print(teamDict)
        teamLabel.text = (teamDict!["country"] as! String)
        divisionLabel.text = "Division: " + (teamDict?["group_letter"] as! String)
        
        APIRequestModel.getMatchData() {
            data, response, error in
            do {
                // try and grab the tasks from ApI and print/use in success
                if let matchActivity = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                    for match in matchActivity{
                        let matchDict = match as! NSDictionary
//                        print(matchDict)
                        let ateam = matchDict["away_team"] as! NSDictionary
                        let hteam = matchDict["home_team"] as! NSDictionary
                        if (ateam["code"] as! String) == (self.teamDict!["fifa_code"] as! String) || (hteam["code"] as! String) == (self.teamDict!["fifa_code"] as! String){
                            if (ateam["code"] as! String) == (self.teamDict!["fifa_code"] as! String){
                                let events = matchDict["away_team_events"] as! [NSDictionary]
                                for event in events{
                                    items.append(event)
                                }
                                
                            }
                            if (hteam["code"] as! String) == (self.teamDict!["fifa_code"] as! String){
                                let events = matchDict["home_team_events"] as! [NSDictionary]
                                for event in events{
                                    items.append(event)
                                }
                            }
                        }
                    }
                    print(items)
                }
                DispatchQueue.main.async {
                    self.detailTableviewController.reloadData()
                }
            } catch {
                //                if error in grabbing data print
                print("Something went wrong")
            }
        }

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func exitOnTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TeamDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = (items[indexPath.row]["player"] as! String) + "  \(items[indexPath.row]["time"] as! String)" + "  \(items[indexPath.row]["type_of_event"] as! String)"
        return cell
    }
    
    

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Section: \(indexPath.section) and Row: \(indexPath.row)")
//
//        tableView.reloadData()
//    }
    //    What cell should I draw in each section

}
