//
//  ViewController.swift
//  Challenge1-3
//
//  Created by 中木翔子 on 2022/05/01.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [String]()
    

    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        title = "World Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
       
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("png") {
                countries.append(item)
            }
        }
            print(countries.sort())
   }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = countries[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
            
    }
}

