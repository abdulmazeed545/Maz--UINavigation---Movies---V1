//
//  BollyWood.swift
//  Maz- UINavigation - Movies - V1
//
//  Created by Shaik abdul mazeed on 06/02/21.
//

import UIKit
import AVKit
import AVFoundation

class BollyWood: UIViewController {

   // var bolly = BollyWoodViewController()
    var AVPlay = AVPlayerViewController()
    var AVSongs = AVPlayerViewController()
    //Creating global variables
    var titleL,actorsL,directorL,industryL,songsL,storyL:UILabel!
    var title1,actors,director,industry,songs,story:UILabel!
    var scrollView1:UIScrollView!
    var songsArray = [AVPlayerViewController]()
    var segment:UISegmentedControl!
    var posterImage = UIImageView()
    var view1 = UIView()
    var movieDetails:MovieDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        displayData()
        // Do any additional setup after loading the view.
    }
    var movieSongs:[String] = []
    var movieActors:[String] = []
    var movieStory:String!
    var movieDirector:String!
    var moviePoster:[String] = []
    var segmentPosters:[UIImageView] = []
    //Creating a function to display data
    func displayData()
    {
        
        //Assigning tag to the movies data
        //movieDetails = movieDataConvert[bolly.tag]
        //Creating variables to store the data
        moviePoster = movieDetails.posters!
        movieDirector = movieDetails.director!
        movieActors = movieDetails.actors!
        let trailers = movieDetails.trailers!
        movieStory = movieDetails.story
        movieSongs = movieDetails.songs!
        //Creating an instance to the the ui view
        view1 = UIView()
        view1.frame = CGRect(x: 0, y: 0, width: Int(view.frame.size.width), height: 300)
        view1.backgroundColor = .black
        view.addSubview(view1)
        
        //Creating a segmented control to display movie details
        segment = UISegmentedControl(items: ["Songs","Actors","Poster","Story"])
        segment.frame = CGRect(x: 0, y: 300, width: view.frame.size.width, height: 50)
        segment.backgroundColor = .systemPink
        segment.apportionsSegmentWidthsByContent = true
        view.addSubview(segment)
        segment.addTarget(self, action: #selector(segmentAction), for: UIControl.Event.valueChanged)
        
        
        //creating a session to play the trailers
        //Creating an instance to the AVPlay to play the video
        AVPlay = AVPlayerViewController()
        AVPlay.view.frame = CGRect(x: 0, y: 0, width: view1.frame.size.width, height: 280)
        
        AVPlay.player = AVPlayer(url: URL(string: "https://services.brninfotech.com/tws/\(trailers[0])".replacingOccurrences(of: " ", with: "%20"))!)
        //AVPlay.entersFullScreenWhenPlaybackBegins = true
        AVPlay.player?.play()
        view1.addSubview(AVPlay.view)
        
        
        
    }
    //Creating an instances to the UIViews
    var songsView = UIView()
    var actorsView = UIView()
    var postersView = UIView()
    var storyView = UIView()
    
    //Creating a function for segment action
    @objc func segmentAction()
    {
        switch segment.selectedSegmentIndex {
        case 0:
            //Calling function to remove the view
            removeView(myView: storyView)
            removeView(myView: actorsView)
            removeView(myView: postersView)
            
            //Creating a view to display the songs in it
            songsView = UIView(frame: CGRect(x: 0, y: 350, width: view.frame.size.width, height: view.frame.size.height))
            songsView.backgroundColor = .cyan
            view.addSubview(songsView)
            
            //Creating a scroll view to the songs view
            scrollView1 = UIScrollView(frame: CGRect(x: 0, y: 0, width: songsView.frame.size.width, height: songsView.frame.size.height))
            songsView.addSubview(scrollView1)
            
            //Condtion to check the whether the songs array is empty or not
            if movieSongs.isEmpty == true
            {
                //Creating an instance to the songs label
                songsL = UILabel(frame: CGRect(x: 20, y: 50, width: Int(songsView.frame.size.width), height: 200))
                songsL.text = "Not Updated"
                songsL.textAlignment = .center
                songsL.textColor = .systemRed
                songsL.font = UIFont(name: "AvenirNext-Bold", size: 25)
                scrollView1.addSubview(songsL)
            }
            //Loop to display and play the songs
            for song in 0..<movieSongs.count
            {
                
                //Creating an instance to play the songs
                AVSongs = AVPlayerViewController()
                AVSongs.player = AVPlayer(url: URL(string: "https://services.brninfotech.com/tws/\(String(movieSongs[song]))".replacingOccurrences(of: " ", with: "%20"))!)
                AVSongs.view.frame = CGRect(x: 20, y: 10+song*52, width: 100, height: 50)
                scrollView1.addSubview(AVSongs.view)
                
                //appending the songs to the songs array
                songsArray.append(AVSongs)
                
                //Creating a constant to store the songs names
                let songsText = movieSongs[song].split(separator: "/")
                songsL = UILabel(frame: CGRect(x: 130, y: 10+song*52, width: Int(songsView.frame.size.width), height: 50))
                songsL.text = "\(songsText[3])"
                songsL.font = UIFont(name: "AvenirNext-Bold", size: 15)
                scrollView1.addSubview(songsL)
                
                //Setting the scrollview content size
                scrollView1.contentSize = CGSize(width: songsView.frame.size.width, height: AVSongs.view.frame.maxY+100)
                
            }
            
        case 1:
            //Calling function to remove the view
            removeView(myView: songsView)
            removeView(myView: storyView)
            removeView(myView: postersView)
            
            //Creating a view to the actors
            actorsView = UIView(frame: CGRect(x: 0, y: 350, width: view.frame.size.width, height: view.frame.size.height))
            actorsView.backgroundColor = .brown
            view.addSubview(actorsView)
            //Loop to display the actors
            for actor in 0..<movieActors.count
            {
                //Creating an instance to the actors labels
                actorsL = UILabel()
                actorsL.text = movieActors[actor]
                actorsL.backgroundColor = .white
                actorsL.sizeToFit()
                actorsL.frame = CGRect(x: 80, y: 20+32*actor, width: 210, height: 30)
                actorsL.textAlignment = .center
                actorsL.clipsToBounds = true
                actorsL.layer.cornerRadius = 5
                actorsL.font = UIFont(name: "AvenirNext-Bold", size: 17)
                actorsView.addSubview(actorsL)
            }
        case 2:
            
            //Calling function to remove the view
            removeView(myView: songsView)
            removeView(myView: actorsView)
            removeView(myView: storyView)
            
            //Creating a view to display the posters
            postersView = UIView(frame: CGRect(x: 0, y: 350, width: view.frame.size.width, height: view.frame.size.height))
            postersView.backgroundColor = .cyan
            view.addSubview(postersView)
            //Creating a data task session to the posters
            var sessionData = URLSession.shared.dataTask(with: URL(string: "https://services.brninfotech.com/tws/\(moviePoster[0])".replacingOccurrences(of: " ", with: "%20"))!) { (poster, _, err) in
                
                DispatchQueue.main.async {
                    //Creating an instance to the posters image
                    self.posterImage.frame = CGRect(x: 0, y: 0, width: self.postersView.frame.size.width, height: 400)
                    self.posterImage.contentMode = .scaleToFill
                    self.posterImage.image = UIImage(data: poster!)
                    self.posterImage.clipsToBounds = true
                    self.posterImage.layer.cornerRadius = 10
                    self.segmentPosters.append(self.posterImage)
                    self.postersView.addSubview(self.posterImage)
                    
                }
            }
            sessionData.resume()//Starts thes session
            
            //Creating an instance to the  director label
            directorL = UILabel()
            directorL.text = "Director: \(movieDirector!)"
            directorL.backgroundColor = .systemPurple
            directorL.textColor = .systemYellow
            directorL.sizeToFit()
            directorL.frame = CGRect(x: 0, y: 405, width: postersView.frame.size.width, height: 50)
            directorL.textAlignment = .center
            directorL.numberOfLines = 0
            directorL.clipsToBounds = true
            directorL.layer.cornerRadius = 5
            directorL.font = UIFont(name: "AvenirNext-Bold", size: 20)
            postersView.addSubview(directorL)
        case 3:
            
            //Calling function to remove the view
            removeView(myView: songsView)
            removeView(myView: actorsView)
            removeView(myView: postersView)
            
            //Creating a view to display the story of the movie
            storyView = UIView(frame: CGRect(x: 0, y: 350, width: view.frame.size.width, height: view.frame.size.height))
            storyView.backgroundColor = .systemPurple
            view.addSubview(storyView)
            //Creation of a label to display the story
            story = UILabel(frame: CGRect(x: 0, y: 350, width: storyView.frame.size.width, height: 450))
            //Condition to check whether the movie story is nil or not
            if movieStory != nil
            {
                story.text = movieStory
                story.textAlignment = .justified
                story.font = UIFont(name: "AvenirNext-Bold", size: 15)
            }else
            {
                story.text = "Story Not Updated"
                story.textAlignment = .center
                story.font = UIFont(name: "AvenirNext-Bold", size: 25)
            }
            story.backgroundColor = .systemPurple
            story.textColor = .black
            story.numberOfLines = 0
            view.addSubview(story)
        default:
            print("NO items")
        }
    }
    //Creating a function for to remove the view from its super view
    func removeView(myView: UIView)
    {
        myView.removeFromSuperview()
    }
}
