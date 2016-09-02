//
//  AppDelegate.swift
//  iDaemon
//
//  Created by Francisco Modesto on 02/09/2016.
//  Copyright © 2016 Francisco Modesto. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)
    let preferences = PreferencesWindow(windowNibName: "PreferencesWindow")

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Start", action: #selector(AppDelegate.startScript(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Stop", action: #selector(AppDelegate.stopScript(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Preferences", action: #selector(AppDelegate.preferences(_:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApp.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.button!.image = NSImage(named: "red")
        statusItem.menu = menu
        
        if NSUserDefaults.standardUserDefaults().boolForKey("activateStartup") ?? false {
            startScript(self)
        }
    }
    
    func startScript(sender: AnyObject) {
        if let cmd = NSUserDefaults.standardUserDefaults().stringForKey("startScript") {
            let task = NSTask()
            task.launchPath = "/bin/bash"
            task.arguments = ["-l", "-c", cmd]
            task.launch()
            
            statusItem.button!.image = NSImage(named: "green")
        }
    }
    
    func stopScript(sender: AnyObject) {
        if let cmd = NSUserDefaults.standardUserDefaults().stringForKey("stopScript") {
            let task = NSTask()
            task.launchPath = "/bin/bash"
            task.arguments = ["-l", "-c", cmd]
            task.launch()
        
            statusItem.button!.image = NSImage(named: "red")
        }
    }
    
    func preferences(sender: AnyObject) {
        NSApplication.sharedApplication().activateIgnoringOtherApps(true)
        preferences.showWindow(self)
        preferences.loadPreferences()
    }
}
