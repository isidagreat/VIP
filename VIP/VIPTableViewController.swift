//
//  VIPTableViewController.swift
//  VIP
//
//  Created by Isidro Arzate on 7/12/18.
//  Copyright © 2018 Isidro Arzate. All rights reserved.
//

import UIKit

class VIPTableViewController: UITableViewController, TeamDetailViewControllerDelegate {
var items = [NSDictionary]()
    override func viewDidLoad() {
        APIRequestModel.getStandings() {
            data, response, error in
            do {
                // try and grab the tasks from ApI and print/use in success
                if let standings = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                        for stand in standings{
                            let standDict = stand as! NSDictionary
                            self.items.append(standDict)
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                //                if error in grabbing data print
                print("Something went wrong")
            }
        }
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        performSegue(withIdentifier: "TeamDetailSegue", sender: indexPath)
        print(indexPath)
    }
    func addTeam(by controller: TeamDetailViewController, with team: NSDictionary) {
//        PlaceHolder to conform to delegate
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if segue.identifier == "TeamDetailSegue"{
            let navigationController = segue.destination as! UINavigationController
            let teamDetailViewController = navigationController.topViewController as! TeamDetailViewController
            let path = self.tableView.indexPathForSelectedRow
                print(path as Any)
            teamDetailViewController.delegate = self
            teamDetailViewController.teamDict = items[(path?.row)!]
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "standingCell", for: indexPath) as! CustomStandingTableViewCell
        cell.countryCodeLabel.text = items[indexPath.row]["fifa_code"] as? String
        cell.winsLabel.text = "Wins: " + "\(items[indexPath.row]["wins"] ?? "n/a")"
        cell.lossesLabel.text = "Losses: " + "\(items[indexPath.row]["losses"] ?? "n/a")"
        cell.teamDict = items[indexPath.row]

        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
