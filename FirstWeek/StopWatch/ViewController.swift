//
//  ViewController.swift
//  StopWatch
//
//  Created by Stan on 2018-02-04.
//  Copyright © 2018 stan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    var timeNumber: Double = 0.0 {
        willSet {
            timerLabel.text = String.init(format: "%.1f", newValue)
        }
    }

    var isPlay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer.setEventHandler { [weak self] in
            self?.timeNumber += 0.1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    lazy var timer: DispatchSourceTimer = {
        let gcdTimer = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags.strict, queue: DispatchQueue.main)
        gcdTimer.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.microseconds(200), leeway: DispatchTimeInterval.never)
        return gcdTimer
    }()

    @IBAction func playBtnClick(_ sender: Any) {
        guard isPlay else {
            startTimer()
            return
        }        
    }
    
    @IBAction func pauseBtnClick(_ sender: Any) {
        if isPlay {
            stopTimer()
        }
    }
    
    @IBAction func resetBtnClick(_ sender: Any) {
        if isPlay {
            stopTimer()
        }
        timeNumber = 0.0
    }
    
    fileprivate func stopTimer() {
        timer.suspend()
        isPlay = false
    }
    
    fileprivate func startTimer() {
        timer.resume()
        isPlay = true
    }
    
}

