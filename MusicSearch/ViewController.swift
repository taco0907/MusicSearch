//
//  ViewController.swift
//  MusicSearch
//
//  Created by 正裕 植田 on 2017/04/30.
//
//

import UIKit

var myTableView: UITableView!
var mySearchBar: UISearchBar!
var items_title: [String] = []
var items_image: [UIImage] = []

var myButton: UIButton!

class ViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let displayWidth:CGFloat = view.self.frame.width
        let displayHeight:CGFloat = view.self.frame.height
        let barHeight:CGFloat = UIApplication.shared.statusBarFrame.size.height
        let searchBarHeight:CGFloat = 50;
        self.showSongs(term: "bjork")
        
        mySearchBar = UISearchBar(frame: CGRect(x: 0, y: barHeight+15, width: displayWidth, height: searchBarHeight))
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight+searchBarHeight+15, width: displayWidth, height: displayHeight))
        myTableView.dataSource = self
        mySearchBar.delegate = self
        
        myButton = UIButton(frame: CGRect(x: 10, y: barHeight, width: 30, height: 15))
        myButton.setTitle("Go", for: .normal)
        myButton.setTitleColor(UIColor.blue, for: .normal)
        myButton.addTarget(self, action: #selector(ViewController.tapButton(_:)), for: .touchUpInside)
        
        self.view.addSubview(mySearchBar)
        self.view.addSubview(myTableView)
        self.view.addSubview(myButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func showSongs(term rv_term:String) {
        let urlString = "https://itunes.apple.com/search?term=\(rv_term)&entity=album&limit=20&lang=ja_jp&country=JP"
        
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url! as URL){ data, response, error in
            if let data = data, let response = response {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                    let jsondata = json["results"] as! [[String:Any]]
                    
                    for song in jsondata {
                        let albumName = song["collectionCensoredName"] as! String
                        items_title.append(albumName)
                    }
                    DispatchQueue.main.async {
                        myTableView.reloadData()
                    }
                    myTableView.reloadData()
                    
                    for song in jsondata{
                        let imageUrl = song["artworkUrl60"] as! String
                        let url = URL(string: imageUrl)
                        let imageData = NSData(contentsOf: url!)
                        let image = UIImage(data: imageData! as Data)
                        items_image.append(image!)
                    }
                    DispatchQueue.main.async {
                        myTableView.reloadData()
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
        return items_title.count
    }
  
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "MyCell")
        
        
        if(indexPath.row < items_title.count) {
            cell.textLabel?.text = items_title[indexPath.row]
        }
        
        if(indexPath.row < items_image.count){
            cell.imageView?.image = items_image[indexPath.row]
        }
        
        return cell   
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let next = storyboard!.instantiateViewController(withIdentifier: "nextView")
     self.present(next, animated: true, completion: nil)

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mySearchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        items_title.removeAll()
        items_image.removeAll()
        myTableView.reloadData()
        
        let text = mySearchBar.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        self.showSongs(term: text)
        
    }
    
    func tapButton(_ sender:UIButton) {
        let next = storyboard!.instantiateViewController(withIdentifier: "nextView")
        self.present(next, animated: true, completion: nil)
    }
    

}

