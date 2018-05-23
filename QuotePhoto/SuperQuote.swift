//
//  SuperQuote.swift
//  QuotePhoto
//
//  Created by Mike Cameron on 2018-05-23.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import Foundation
import UIKit


class SuperQuote : NSObject {
    
    var quoteText: String
    var quoteAuthor: String
    var quoteLink: String
    var photo: UIImage
    var sumPhoto: UIImage?
    
    init(quoteText: String, quoteAuthor: String, quoteLink: String, photo: UIImage) {
        self.quoteText = quoteText
        self.quoteAuthor = quoteAuthor
        self.quoteLink = quoteLink
        self.photo = photo

    }

}
