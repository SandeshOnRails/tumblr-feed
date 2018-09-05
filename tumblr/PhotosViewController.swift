//
//  PhotosViewController.swift
//  tumblr
//
//  Created by Sandesh Basnet on 8/28/18.
//  Copyright © 2018 Sandesh Basnet. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var posts: [[String: Any]] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchData()
        self.navigationController?.navigationBar.isHidden = false
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 250
        
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        let  cell = tableView.dequeueReusableCell(withIdentifier:"PhotoCell") as! PhotoCell

        
        let post = self.posts[indexPath.row]
        
        if let photos = post["photos"] as? [[String: Any]] {
            
            let photo = photos[0]
            
            let original = photo["original_size"] as! [String: Any]
            
            let urlPath = original["url"] as! String
            
            let url = URL(string: urlPath)
        
            cell.posterImage?.af_setImage(withURL: url!)
            
            
            
        }
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    @objc func refreshControlAction (_ refreshControl: UIRefreshControl) {
        
        fetchData()
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
        
    }
    
    
    func fetchData() {
        
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        
           let request = URLRequest(url:url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)

        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                
                //print(dataDictionary)
                
                let response = dataDictionary ["response"] as! [String:Any]
                
                self.posts = response["posts"] as! [[ String: Any]]
                
                self.tableView.reloadData()
                
                
            }
            
            
        }
        
        
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        
        if let indexPath = tableView.indexPath(for: cell) {
        
            let post = self.posts[(indexPath.row)]
            
            if let photos = post["photos"] as? [[String: Any]] {
                
                let photo = photos[0]
                
                let original = photo["original_size"] as! [String: Any]
                
                let urlPath = original["url"] as! String
                
                let url = URL(string: urlPath)
                
                
                let detailViewController = segue.destination as! PhotosDetailViewController
                
                detailViewController.imageUrl = urlPath
                
                
                
            }
            
            
            
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
