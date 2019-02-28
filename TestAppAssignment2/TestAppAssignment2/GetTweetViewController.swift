//
//  ViewController.swift
//  TestAppAssignment2
//
//  Created by Mitchell Holmes on 2019/02/20.
//  Copyright © 2019 Mitchell Holmes. All rights reserved.
//

import UIKit
import MitchHolmesSynchronousPosterGetter
class GetTweetViewController: UIViewController {
    let baseURL = "http://jsonplaceholder.typicode.com"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var tweetIdTextField: UITextField!
    @IBOutlet weak var tweetTitleTextView: UITextView!
    @IBOutlet weak var tweetBodyTextView: UITextView!
    @IBAction func findTweetTapped(_ sender: Any) {
        if let userId = userIdTextField.text, let tweetId = tweetIdTextField.text {
            let params = ["userId": userId, "tweetId": tweetId]
            DispatchQueue.global().async {
                let tweet = TweetService.getTweet(url: self.baseURL, paramaters: params)
                self.updateUI(tweets: tweet)
            }
        }
    }

    func updateUI (tweets: [TweetService.Tweet]) {
        DispatchQueue.main.async { [weak self] in
            for tweet in tweets {
                self?.tweetTitleTextView.text = tweet.title
                self?.tweetBodyTextView.text = tweet.body
            }
        }
    }
}
