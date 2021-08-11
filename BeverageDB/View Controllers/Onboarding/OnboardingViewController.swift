//
//  OnboardingViewController.swift
//  BeverageDB
//
//  Created by Gugu Ndaba on 2021/08/05.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var currentPage = 0 {
        //Registers when the page control value has changed, ie. the page
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {    //If the user is on the last page
                nextButton.setTitle("Let's go!", for: .normal)
            } else {
                nextButton.setTitle(">", for: .normal)
            }
        }
    }
    
    private let storageManager = StorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            OnboardingSlide(title: "Fabulous Cocktails", description: "Make a cocktail drink to enjoy on any day under any climate.", image: UIImage(imageLiteralResourceName: "slide11")),
            OnboardingSlide(title: "Wide range of base spirits", description: "Find a base spirit of your liking and create stunning drinks to complement their flavour.", image: UIImage(imageLiteralResourceName: "slide22")),
            OnboardingSlide(title: "Search any beverage", description: "Find a drink by name and get instructions and ingredients on the most popular ways to make it.", image: UIImage(imageLiteralResourceName: "slide33"))
        ]
        
        updateOnboarding()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func updateOnboarding() {
        storageManager.setOnboardingViewed()
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(identifier: "HomeTabBar") as! UITabBarController
            
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .coverVertical
            
            present(controller, animated: true, completion: nil)    //'completion: nil' -> does not have to let the user know when the animation completes
        } else {
            currentPage += 1    //...Increases the page number by 1 everytime the 'next' button is clicked; moves to next page. Important!, otherwise next page will not show!
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)   //Moves to the next page...
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setUp(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewFlowLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    //enables the page control to animate the changing of pages, ie. scrolling
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        //pageControl.currentPage = currentPage
    }
}
