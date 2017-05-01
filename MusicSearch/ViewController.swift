//
//  ViewController.swift
//  MusicSearch
//
//  Created by 正裕 植田 on 2017/04/30.
//
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
                        print(trackName)
                    }
                }catch{
                    print("Json Serialize Error")
                }
            }else{
                print(error ?? "Error")
            }
        }.resume()
   
    }

}

