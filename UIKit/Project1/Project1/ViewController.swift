//
//  ViewController.swift
//  Project1
//
//  Created by 中木翔子 on 2022/04/05.
//

import UIKit

class ViewController: UITableViewController {
     var pictures = [String]()
    
   override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))

        
        title = "Storm Viewer"
         
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
     
     
        for item in items {
             
            if item.hasPrefix("nssl") {
                // this is a pictures to load!
                
                pictures.append(item)
                
            }
        }
         print(pictures.sort())
    }

     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
          return pictures.count
          
     }
     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
         cell.textLabel?.text = pictures[indexPath.row]
         cell.textLabel!.font = UIFont.systemFont(ofSize: 18)
         
         return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
             
             vc.position = (position: indexPath.row + 1, total: pictures.count)
             
            navigationController?.pushViewController(vc, animated: true)
        }
    }
     
     @objc func shareApp() {
          
         
         let vc = UIActivityViewController(activityItems: [], applicationActivities: [])
         vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
         present(vc,animated: true)
     }
     
}


