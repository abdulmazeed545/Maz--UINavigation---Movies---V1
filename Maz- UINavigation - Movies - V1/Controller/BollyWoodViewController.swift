//
//  BollyWoodViewController.swift
//  Maz- UINavigation - Movies - V1
//
//  Created by Shaik abdul mazeed on 05/02/21.
//

import UIKit

class BollyWoodViewController: UIViewController {
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
        //scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height+5000)
        scrollView.layer.masksToBounds = true
        view.addSubview(scrollView)
        
        
       //For loop to posters
        for poster in 0..<movieDataConvert.count
        {
            
            let industry = movieDataConvert[poster].industry
            
            if industry == "Bollywood"
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
                            label.textColor = .white
                            label.sizeToFit()
                            scrollView.addSubview(label)
                            self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.imageViews.frame.maxY)
                            
                            
                            //Incrementing the y value
                            self.y += 1
                        }
                    }else
                    {
                        label = UILabel(frame: CGRect(x: 20, y: 250, width: view.frame.size.width, height: 200))
                        label.text = "Sorry! There are no Movies"
                        label.numberOfLines = 0
                        label.backgroundColor = .orange
                        scrollView.addSubview(label)
                    }
                }
                dataObj.resume()
            }
        }
      /*  //Creating variables for different industries to store the data
        var bollyIndustry:[String] = []
        var moviePosters:[String] = []
        var bollyTitle:[String] = []
        //For loop to posters
        for poster in 0..<movieDataConvert.count
        {
            //Variables to store the data
            let industry = movieDataConvert[poster].industry
            let posters = movieDataConvert[poster].posters!
            let title = movieDataConvert[poster].title!
            //Condition to check the industry
            if industry == "Bollywood"
            {
                bollyIndustry.append(industry!)
                moviePosters.append(contentsOf: posters)
                bollyTitle.append(title)
            }
        }
        
        if bollyIndustry.count > 0
        {
            for i in 0..<bollyIndustry.count
            {
                
                //Creating a session to the data task
                var dataObj = URLSession.shared.dataTask(with: URL(string: "https://services.brninfotech.com/tws/\(moviePosters[i])".replacingOccurrences(of: " ", with: "%20"))!) { (data, res, err) in
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
                        self.imageViews.tag = i
                        
                        self.imgViewArr.append(self.imageViews)
                        //Adding tap gesture to the imageview
                        self.imageViews.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapAction(tap:))))
                        
                        //self.view1.addSubview(self.imageViews)
                        self.scrollView.addSubview(self.imageViews)
                        label = UILabel()
                        label.frame = CGRect(x: 210, y: 30+105*y, width: 150, height: 100)
                        label.text = "Movie Title:\n \(bollyTitle[i])"
                        label.numberOfLines = 0
                        label.font = UIFont(name: "AvenirNext-Bold", size: 17)
                        label.textColor = .white
                        label.sizeToFit()
                        scrollView.addSubview(label)
                        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.imageViews.frame.maxY)
                        
                        
                        //Incrementing the y value
                        self.y += 1
                        
                    }
                }
                dataObj.resume()
            }
            }else
        {
            DispatchQueue.main.async { [self] in
                label = UILabel()
                label.frame = CGRect(x: 20, y: 150, width: 300, height: 200)
                label.text = "Sorry! There are No Movies from server Please Move to Another Wood movies"
                label.numberOfLines = 0
                label.textAlignment = .justified
                label.font = UIFont(name: "AvenirNext-Bold", size: 30)
                label.textColor = .systemRed
                label.sizeToFit()
                scrollView.addSubview(label)
            }
            
        }*/
        
        
        
    }
    
    
    var tag:Int!
    
     //Creating a function for tap action
     @objc func tapAction(tap:UITapGestureRecognizer)
     {
        tag = tap.view!.tag
        
        //Creating an instance tot he viewcontroller2 class
        let bollyData = (storyboard?.instantiateViewController(identifier: "BollyWood1"))! as BollyWood
        bollyData.modalPresentationStyle = .fullScreen
        bollyData.movieDetails = movieDataConvert[tag]
        //var movieData = movieDataConvert[tag]
        self.navigationController?.pushViewController(bollyData, animated: true)
        
     }
}
