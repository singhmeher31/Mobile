//
//  TableDataViewController.swift
//  Project
//
//  Created by Meher Jyoti Singh on 4/16/18.
//  Copyright © 2018 Meher Jyoti Singh. All rights reserved.
//

import UIKit

class TableDataViewController: UITableViewController, VideoModelDelegate {
    
    @IBOutlet var Tableview: UITableView!
    var videos:[Video] = [Video]()
    
    var selectedVideo:Video?
    let model:VideoModel = VideoModel()
    
    //var searchController = UISearchController()
    //var resultsController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.delegate = self
        model.getFeedVideos()
        
        //searchController = UISearchController(searchResultsController: resultsController)
        //Tableview.tableHeaderView = searchController.searchBar
        //searchController.searchResultsUpdater = self
        
        //resultsController.tableView.delegate = self
        //resultsController.tableView.dataSource = self
    }
    
    func dataReady() {
        //Access video objects that have been downloaded
        self.videos = self.model.videoArray
        //tell the tableView to reload
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.width / 320) * 180
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
    
        let videoThumbnailUrlString = videos[indexPath.row].videoThumbnailUrl
        
        let videoThumbNailUrl = URL(string: videoThumbnailUrlString)
        
        if videoThumbNailUrl != nil {
            let request = URLRequest(url: videoThumbNailUrl!)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
                
                DispatchQueue.main.async(execute: { () -> Void in
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    
                    imageView.image = UIImage(data: data!)
                })
            })
            dataTask.resume()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedVideo = self.videos[indexPath.row]
        self.performSegue(withIdentifier: "gotoDetail", sender: self)
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
    */
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let detailViewController = segue.destination as! VideoViewController
        
        // Pass the selected object to the new view controller.
        detailViewController.selectedVideo = self.selectedVideo
        
    }


    @IBAction func SignoutButton(_ sender: Any) {
        
        GIDSignIn.sharedInstance().signOut()
        navigationController?.dismiss(animated: true, completion: nil) //come back to main viewcontroller
        print("User has Logged Out")
    }
    
}
