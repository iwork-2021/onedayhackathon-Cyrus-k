//
//  DisplayTableViewController.swift
//  albumapp
//
//  Created by nju on 2021/12/21.
//

import UIKit

var items:[PhotoAlbum] =
[
    PhotoAlbum(title: "apple"),
    PhotoAlbum(title: "banana"),
    PhotoAlbum(title: "cake"),
    PhotoAlbum(title: "candy"),
    PhotoAlbum(title: "carrot"),
    PhotoAlbum(title: "cookie"),
    PhotoAlbum(title: "doughnut"),
    PhotoAlbum(title: "grape"),
    PhotoAlbum(title: "hot dog"),
    PhotoAlbum(title: "ice cream"),
    PhotoAlbum(title: "juice"),
    PhotoAlbum(title: "muffin"),
    PhotoAlbum(title: "orange"),
    PhotoAlbum(title: "pineapple"),
    PhotoAlbum(title: "popcorn"),
    PhotoAlbum(title: "pretzel"),
    PhotoAlbum(title: "salad"),
    PhotoAlbum(title: "strawberry"),
    PhotoAlbum(title: "waffle"),
    PhotoAlbum(title: "watermelon"),
    PhotoAlbum(title: "other")
]


class DisplayTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DisplayCell", for: indexPath) as! DisplayTableViewCell
        
        let item = items[indexPath.row]
        
        //cell = DisplayTableViewCell.init(style: .subtitle, reuseIdentifier: "DisplayCell")
        //cell.detailTextLabel?.text = "70% precision"
        cell.title.text! = item.title
        cell.subtitle.text! = "70% precision  " + String(format: "%d", item.photoimage.count) + " items"
        //cell.detailTextLabel?.text = "70% precision"
        
        // Configure the cell...

        return cell

        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)!.selectionStyle = UITableViewCell.SelectionStyle.none
        self.tableView.reloadData()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "DisplaySegue"{
            print(1)
            let itemTableViewController = segue.destination as! ItemTableViewController
            let cell = sender as! DisplayTableViewCell
            itemTableViewController.Photoimage = items[tableView.indexPath(for: cell)!.row].photoimage
            print(itemTableViewController.Photoimage.count)
            //print(itemTableViewController.Photoimage[0])
            itemTableViewController.photocategory = items[tableView.indexPath(for: cell)!.row].title
            print(itemTableViewController.photocategory)
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
