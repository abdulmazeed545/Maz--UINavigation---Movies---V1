//
//  OtherViewController.swift
//  Maz- UINavigation - Movies - V1
//
//  Created by Shaik abdul mazeed on 05/02/21.
//

import UIKit

class OtherViewController: UIViewController {
    //Creating global variables
    var requestURL:URLRequest!
    var session:URLSessionDataTask!
    //Creating an instance to the UILabel class
    var label:UILabel!
    var imageViews = UIImageView()
    var imgViewArr:[UIImageView] = []
    //var movieDataConvert = [MovieDetails]()
    var scrollView:UIScrollView!
    var y:Int = 0
    var i:Int = 0
    var postersArray:[String] = []
    var songsArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Calling function
        movieDetails()
        
        // Do any additional setup after loading the view.
    }
    
    //Creating a function
    func movieDetails()
    {
        //Creating an instance to the scrollview
        scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
       // scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height+5000)
        scrollView.layer.masksToBounds = true
        view.addSubview(scrollView)
        
        
        //For loop to posters
        for poster in 0..<movieDataConvert.count
        {
            
            let industry = movieDataConvert[poster].industry
            let posters = movieDataConvert[poster].posters!
              
           
            if (industry != "Bollywood" && industry != "Hollywood" && industry != "Tollywood")
            {
                let title = movieDataConvert[poster].title!
                print(title)
                //Creating a session to the data task
                var dataObj = URLSession.shared.dataTask(with: URL(string: "https://services.brninfotech.com/tws/\(movieDataConvert[poster].posters![0])".replacingOccurrences(of: " ", with: "%20"))!) { [self] (data, res, err) in
                    if data != nil{
                        DispatchQueue.main.async { [self] in
                            
                            //Creating an instance to the imageview
                            self.imageViews = UIImageView()
                            self.imageViews.image = UIImage(data: data!)
                            self.imageViews.frame = CGRect(x: 20, y: 30+105*y, width: 150, height: 100)
                            self.imageViews.backgroundColor = UIColor.green
                            self.imageViews.isUserInteractionEnabled = true
                            self.imageViews.clipsToBounds = true
                            self.imageViews.layer.cornerRadius = 10
                            //Assigning tag to the posters
                            self.imageViews.tag = poster
                            
                            self.imgViewArr.append(self.imageViews)
                            //Adding tap gesture to the imageview
                            self.imageViews.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapAction(tap:))))
                            
                            //self.view1.addSubview(self.imageViews)
                            self.scrollView.addSubview(self.imageViews)
                            label = UILabel()
                            label.frame = CGRect(x: 210, y: 30+105*y, width: 150, height: 100)
                            label.text = "Movie Title:\n \(title)"
                            label.numberOfLines = 0
                            label.font = UIFont(name: "AvenirNext-Bold", size: 17)
                            label.textColor = .systemRed
                            label.sizeToFit()
                            scrollView.addSubview(label)
                            
                            
                            
                            //Incrementing the y value
                            self.y += 1
                            self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.imageViews.frame.maxY+100)
                        }
                    }else
                    {
                        self.label = UILabel(frame: CGRect(x: 20, y: 250, width: view.frame.size.width, height: 200))
                        label.text = "Sorry! There are no Movies"
                        self.label.numberOfLines = 0
                        label.backgroundColor = .orange
                        scrollView.addSubview(label)
                    }
                }
                dataObj.resume()
            }
            
        }
      
    }
    
    
    var tag:Int!
    
     //Creating a function for tap action
     @objc func tapAction(tap:UITapGestureRecognizer)
     {
        tag = tap.view!.tag
        
        //Creating an instance tot he viewcontroller2 class
        let otherData = (storyboard?.instantiateViewController(identifier: "BollyWood1"))! as BollyWood
        otherData.modalPresentationStyle = .fullScreen
        otherData.movieDetails = movieDataConvert[tag]
        
        self.navigationController?.pushViewController(otherData, animated: true)
        
     }
}
