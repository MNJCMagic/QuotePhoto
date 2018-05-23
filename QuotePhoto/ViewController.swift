//
//  ViewController.swift
//  QuotePhoto
//
//  Created by Mike Cameron on 2018-05-23.
//  Copyright © 2018 Mike Cameron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuoteViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var networkManager: NetworkManager = NetworkManager()
    var quote: Quote?
    //var superQuote: SuperQuote?
    var superQuoteArray: [SuperQuote]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.superQuoteArray = [SuperQuote]()
        networkManager.fetchNewQuote { (data, error) -> (Void) in
            let decoder = JSONDecoder()
            let newQuote = try! decoder.decode(Quote.self, from: data!)
            DispatchQueue.main.async {
                self.quote = newQuote
                print("\(self.quote!.quoteText)")
            }
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "quoteSegue" {
            let nav = segue.destination as! UINavigationController
            let dVc = nav.topViewController as! QuoteViewController
            dVc.delegate = self
            dVc.quote = self.quote
        }
    }

    //DELEGATE
    func takeSuperQuote(superQuote: SuperQuote) {
        self.superQuoteArray?.append(superQuote)
        self.tableView.reloadData()
    }
    
    //TABLE VIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.superQuoteArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "superCell", for: indexPath)
        cell.imageView?.image = self.superQuoteArray![indexPath.row].photo
        cell.textLabel!.text = self.superQuoteArray![indexPath.row].quoteText
       // cell.detailTextLabel!.text = self.superQuoteArray![indexPath.row].quoteAuthor
        return cell
    }
    
    //ACTIVITY THING
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photo = superQuoteArray![indexPath.row].sumPhoto
        let activityThing = UIActivityViewController.init(activityItems: [photo!], applicationActivities: nil)
        present(activityThing, animated: true, completion: nil)
    }

}

