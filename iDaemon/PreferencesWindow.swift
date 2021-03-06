//
//  PreferencesWindow.swift
//  iDaemon
//
//  Created by Francisco Modesto on 02/09/2016.
//  Copyright © 2016 Francisco Modesto. All rights reserved.
//

import Cocoa

class PreferencesWindow: NSWindowController {

    @IBOutlet weak var startScript: NSTextField!
    @IBOutlet weak var stopScript: NSTextField!
    @IBOutlet weak var activateStartup: NSButton!
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func loadPreferences() {
        startScript.stringValue = NSUserDefaults.standardUserDefaults().stringForKey("startScript") ?? ""
        stopScript.stringValue = NSUserDefaults.standardUserDefaults().stringForKey("stopScript") ?? ""
        activateStartup.state = (NSUserDefaults.standardUserDefaults().boolForKey("activateStartup") ?? false) ? NSOnState : NSOffState
    }
    
    @IBAction func save(sender: NSButton) {
        NSUserDefaults.standardUserDefaults().setValue(startScript.stringValue, forKey: "startScript")
        NSUserDefaults.standardUserDefaults().setValue(stopScript.stringValue, forKey: "stopScript")
        NSUserDefaults.standardUserDefaults().setValue(activateStartup.state == NSOnState, forKey: "activateStartup")
        NSUserDefaults.standardUserDefaults().synchronize()
        window?.close()
    }
}
