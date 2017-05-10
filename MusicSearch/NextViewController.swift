//
//  NextViewController.swift
//  MusicSearch
//
//  Created by 正裕 植田 on 2017/05/10.
//
//

import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var myBackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        myBackButton.addTarget(self, action: #selector(NextViewController.tapBackButton(_:)) ,for: .touchUpInside)
        view.addSubview(myBackButton)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapBackButton(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
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
