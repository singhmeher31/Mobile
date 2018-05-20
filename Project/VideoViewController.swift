//
//  VideoViewController.swift
//  Project
//
//  Created by Meher Jyoti Singh on 5/2/18.
//  Copyright © 2018 Meher Jyoti Singh. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!

    var selectedVideo:Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let keyWindow = UIApplication.shared.keyWindow
        let view = UIView(frame: (keyWindow?.frame)!)
        //view.backgroundColor = UIColor.white
        
        let height = (keyWindow?.frame.width)! * 15 / 16
        let myWebView: UIWebView = UIWebView(frame: CGRect(x: 0, y: 0, width: keyWindow!.frame.width, height: height))
        if let detailVideo = self.selectedVideo {
            
           // let width = self.view.frame.size.width
           // let height = width/320 * 180
           
            if let vid = self.selectedVideo{
                let videoEmbedString = URL(string: "https://www.youtube.com/embed/\(vid.videoId)")
                
                let request = URLRequest(url: videoEmbedString!)
                
               webView.load(request)
                self.view.addSubview(webView)
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveLinear,
                               animations: {
                                self.view.frame = self.webView.frame
                },
                               completion: {(completedAnimation) in
                                //UIApplication.shared.setStatusBarHidden(true, with: .fade)
                })
                
                
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
