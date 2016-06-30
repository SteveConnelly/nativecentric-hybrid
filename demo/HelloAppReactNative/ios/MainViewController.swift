//
//  MainViewController.swift
//  HelloAppReact
//
//  Created by Torey Lomenda on 4/19/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var nextLyricLabel: UILabel!
  
  @IBOutlet weak var buttoniOSSings: UIButton!
  @IBOutlet weak var buttonWebSings: UIButton!
  @IBOutlet weak var buttonRandomSings: UIButton!
  
  var reactView:RCTRootView!
  var tableView:UITableView!
  var items:NSMutableArray = ["Who's Singing?" as NSString]
  
  let lyricsManager:LyricsManager = LyricsManager()
  
  // MARK: init View Controller
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
    super.init(nibName: nil, bundle: nil)
  }
  
  // MARK: View Controller Lifecycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Setup the React View
    let jsCodeLocation = (UIApplication.sharedApplication().delegate as! AppDelegate).jsCodeLocation
    self.reactView = RCTRootView(bundleURL: jsCodeLocation, moduleName: "HelloApp", initialProperties: nil, launchOptions: nil)
    
    self.view.addSubview(reactView)
    
    //set the bridge 
    lyricsManager.defaultBridge = reactView.bridge
    
    // Add Button Events
    buttoniOSSings.addTarget(self, action: #selector(MainViewController.lionelSingsTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    buttonWebSings.addTarget(self, action: #selector(MainViewController.adeleSingsTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    buttonRandomSings.addTarget(self, action: #selector(MainViewController.randomSingsTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)
    
    // add table view
    tableView = UITableView(frame: CGRectMake(100, 550, 200, 200))
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    self.view.addSubview(tableView)
  }
  override func viewWillAppear(animated: Bool) {
    resizeView()
    
    // Call super last
    super.viewWillAppear(animated)
  }
  override func viewDidAppear(animated: Bool) {
    // Call super first
    super.viewDidAppear(animated)
  }
  override func viewWillDisappear(animated: Bool) {
    // Call super last
    super.viewWillDisappear(animated)
  }
  override func viewDidDisappear(animated: Bool) {
    // Call super first
    super.viewDidDisappear(animated)
    
    // Force rebuild of the view
    self.view = nil
  }
  
  // MARK: Rotation Support
  override func shouldAutorotate() -> Bool {
    return true
  }
  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.All
  }
  override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
    resizeView()
  }
  
  // MARK: Memory Warning Support
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: iOS 7/8 Related Methods
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  override func prefersStatusBarHidden() -> Bool {
    return false
  }
  
  // MARK: UITableView
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.items.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
    
    cell.textLabel?.text = self.items[indexPath.row] as? String
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("You selected cell #\(indexPath.row)!")
  }
  
  // MARK: Accessor Methods
  
  // MARK: Public Methods
  
  // MARK:  Private Methods
  func resizeView() {
    let bounds = self.view.bounds
    
    self.reactView.frame = CGRectMake(0, bounds.height/2, bounds.width, bounds.height/2)
  }
  
  // MARK:  Private Button Methods
  func lionelSingsTapped(sender:UIButton) {
    lyricsManager.playNextLyricForLionel()
  }
  
  func adeleSingsTapped(sender:UIButton) {
    lyricsManager.playNextLyricForAdele()
  }
  
  func randomSingsTapped(sender:UIButton) {
    lyricsManager.playNextRandomLyric()
  }
}
