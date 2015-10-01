//
//  ViewController.swift
//  StaticTable
//
//  Created by Greg Spiers on 01/10/2015.
//  Copyright © 2015 Greg Spiers. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UITableViewController {
    let urlToOpen = NSURL(string: "http://bbc.co.uk")!

    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var openURLButton: UIButton!
    @IBOutlet weak var openSafariViewControllerButton: UIButton!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // NOTE! Don't be tempted by these properties, they don't work on iOS 9, you must implement the delegate methods.
        // self.tableView.rowHeight = UITableViewAutomaticDimension
        // self.tableView.estimatedRowHeight = 44.0

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contentSizeCategoryDidChangeNotification:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    // MARK: - Actions
    @IBAction func openURLButtonTapped(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(urlToOpen)
    }

    @IBAction func openSafariViewControllerButtonTapped(sender: AnyObject) {
        // Of course in a real app you would only have one button and then do the check to see if you use SFVC or openURL
        if #available(iOS 9.0, *) {
            let svc = SFSafariViewController(URL: urlToOpen)
            self.presentViewController(svc, animated: true, completion: nil)
        } else {
            UIApplication.sharedApplication().openURL(urlToOpen)
        }
    }

    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    // MARK: - Notifications
    func contentSizeCategoryDidChangeNotification(notification: NSNotification) {
        setFonts()
    }

    // MARK: - Private
    func setFonts() {
        self.longLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.openURLButton.titleLabel!.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.openSafariViewControllerButton.titleLabel!.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }

}

