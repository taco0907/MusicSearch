//
//  ViewController.swift
//  MusicSearch
//
//  Created by 正裕 植田 on 2017/04/30.
//
//

import UIKit

var myTableView: UITableView!
var items: [String] = []

class ViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let displayWidth:CGFloat = view.self.frame.width
        let displayHeight:CGFloat = view.self.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 10, y: 10, width: displayWidth, height: displayHeight))
        myTableView.dataSource = self
        self.view.addSubview(myTableView)
        
        self.showSongs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func showSongs() {
        let urlString = "https://itunes.apple.com/search?term=Beatles&entity=musicTrack&limit=5&lang=ja_jp&country=JP"
        
        
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!){ data, response, error in
            if let data = data, let response = response {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                    let jsondata = json["results"] as! [[String:Any]]
                    
                    for song in jsondata {
                        let trackName = song["trackName"] as! String
                        items.append(trackName)
                    }
                }catch{
                    print("Json Serialize Error")
                }
            }else{
                print(error ?? "Error")
            }
        }.resume()
   
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
  
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "MyCell")
        cell.textLabel?.text = items[indexPath.row]
        
        return cell   
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select: ¥(indexPath.row)")
    }
    


}

