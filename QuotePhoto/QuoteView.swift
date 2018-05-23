//
//  QuoteView.swift
//  QuotePhoto
//
//  Created by Mike Cameron on 2018-05-23.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit
import Nuke

class QuoteView: UIView {

//    var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
//    var quoteLabel = UILabel(frame: CGRect(x: 30, y: 30, width: 240, height: 40))
//    var authorLabel = UILabel(frame: CGRect(x: 60, y: 240, width: 80, height: 40))
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    
    func setUpWithQuote(quote: Quote) {
        self.quoteLabel.text = quote.quoteText
        self.authorLabel.text = quote.quoteAuthor
        let url = URL(string: "https://picsum.photos/300/?random")
            Manager.shared.loadImage(with: url!, into: imageView)
    }
    


}
