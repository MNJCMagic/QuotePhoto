//
//  QuoteViewController.swift
//  QuotePhoto
//
//  Created by Mike Cameron on 2018-05-23.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit
import Nuke

protocol QuoteViewControllerDelegate {
    func takeSuperQuote (superQuote: SuperQuote)
}

class QuoteViewController: UIViewController {
    var quote: Quote?
    var qView: QuoteView?
    var networkManager: NetworkManager?
    var delegate: QuoteViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.networkManager = NetworkManager()
        if let objects = Bundle.main.loadNibNamed("QuoteView", owner: nil, options: [:]), let qView = objects.first as? QuoteView {
            self.view.addSubview(qView)
            self.qView = qView
        }

        self.qView?.frame = CGRect(x: self.view.frame.midX - 150, y: 60, width: 300, height: 300)
        self.qView!.authorLabel.numberOfLines = 0
        self.qView!.authorLabel.lineBreakMode = .byWordWrapping
        //self.qView!.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        self.qView!.setUpWithQuote(quote: self.quote!)
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: SNAPSHOT
    func snapshot(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let sumPhoto = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return sumPhoto!
    }
    
    
    //MARK: ACTIONS

    @IBAction func saveButton(_ sender: Any) {
        let superQuote = SuperQuote(quoteText: (self.quote?.quoteText)!, quoteAuthor: (self.quote?.quoteAuthor)!, quoteLink: (self.quote?.quoteLink)!, photo: (self.qView?.imageView.image)!)
        let sumPhoto = snapshot(view: self.qView!)
        superQuote.sumPhoto = sumPhoto
        self.delegate!.takeSuperQuote(superQuote: superQuote)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func quoteButton() {
        self.networkManager!.fetchNewQuote { (data, error) -> (Void) in
            let decoder = JSONDecoder()
            let newQuote = try! decoder.decode(Quote.self, from: data!)
            DispatchQueue.main.async {
                self.quote = newQuote
                self.qView!.setUpWithQuote(quote: self.quote!)
                print("\(self.quote!.quoteText)")
            }
            
        }
    }
    
    
    @IBAction func imageButton() {
        self.networkManager?.downloadImage(completion: { (image) in
            self.qView?.imageView.image = image
        })

    }
    
    
}
