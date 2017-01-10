//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Flavio Kreis on 09/01/17.
//  Copyright © 2017 Flavio Kreis. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var buttonsSoundStackView: UIStackView!
    @IBOutlet weak var line1StackView: UIStackView!
    @IBOutlet weak var line2StackView: UIStackView!
    @IBOutlet weak var line3StackView: UIStackView!
    @IBOutlet weak var stopButtonStackView: UIStackView!
    
    
    var recordedAudioURL: URL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Actions
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    func setStackViewAxis(_ isPortrait: Bool){
        var mainStackViewsOrientatcion: UILayoutConstraintAxis;
        var buttonsStackViewsOrientatcion: UILayoutConstraintAxis;
        
        if(isPortrait){
            mainStackViewsOrientatcion = .vertical
            buttonsStackViewsOrientatcion = .horizontal
        }
        else {
            mainStackViewsOrientatcion = .horizontal
            buttonsStackViewsOrientatcion = .vertical
        }
        
        self.mainStackView.axis = mainStackViewsOrientatcion
        self.buttonsSoundStackView.axis = mainStackViewsOrientatcion
        self.stopButtonStackView.axis = mainStackViewsOrientatcion
        
        self.line1StackView.axis = buttonsStackViewsOrientatcion
        self.line2StackView.axis = buttonsStackViewsOrientatcion
        self.line3StackView.axis = buttonsStackViewsOrientatcion
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (context) in
            self.setStackViewAxis(UIApplication.shared.statusBarOrientation.isPortrait)
        }, completion: nil)
        
    }
}
