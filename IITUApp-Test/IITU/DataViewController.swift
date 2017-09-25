//
//  DataViewController.swift
//  IITU
//
//  Created by Oleg Nadezhuk on 22.09.17.
//  Copyright © 2017 Oleg Nadezhuk. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel! 
    var dataObject: String = "" 

	@IBOutlet weak var questionText: UITextView!
	var questionNumber = 0;
	var variantsList = [[String]]()
	var questionsList = [String]()
	var answersList = [Int]()
	var score = 0
	var rounds = 0
	var questionCheck = [Int]()
    var answerArray = [Int]()
    
	@IBOutlet weak var scoreTitle: UILabel!
	@IBOutlet weak var scoreValue: UILabel!
    @IBOutlet weak var scorePercent: UILabel!
    @IBOutlet weak var scoreLetter: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		questionsList = ["Contains data of some type. May be changed.", "Contains data of some type. May not be changed.", "... is used in Java", "... is part of architecture"]
//		shuffle(&questionsList)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var item1: UIButton!
	@IBOutlet weak var item2: UIButton!
	@IBOutlet weak var item3: UIButton!
	@IBOutlet weak var item4: UIButton!
	
    
    @IBAction func Back(_ sender: UIButton) {
        questionNumber = questionNumber - 1
        rounds = rounds - 1
        if answerArray[answerArray.count-1] == 1 {
            score = score - 1
        }
        answerArray.removeLast()
        viewWillAppear(true)
    }
    
    @IBOutlet weak var backButton: UIButton!
    
	@IBAction func AnswerGiven(_ sender: UIButton) {
		let answer = sender.titleLabel!.text!
		let temp = variantsList[questionNumber]
		let index = temp.index(of: answer)
		if index == answersList[questionNumber] {
			score = score + 1
            answerArray.append(1)
		}
        else {
            answerArray.append(0)
        }
		rounds = rounds + 1
		if rounds == questionsList.count {
			item1.isHidden = true
			item2.isHidden = true
			item3.isHidden = true
			item4.isHidden = true
			questionText.isHidden = true
			scoreTitle.isHidden = false
			scoreValue.isHidden = false
            scorePercent.isHidden = false
            scoreLetter.isHidden = false
            scoreValue.text = String(score) + "/" + String(questionsList.count)
            let percent = (score * 100) / questionsList.count
            if percent > 90 {
                scoreLetter.text = "A"
            }
            else {
                if percent > 75 {
                    scoreLetter.text = "B"
                }
                else {
                    if percent > 50 {
                        scoreLetter.text = "C"
                    }
                    else {
                        scoreLetter.text = "D"
                    }
                }
            }
            scorePercent.text = String(percent) + "%"
		}
		else {
			questionNumber = questionNumber + 1
			viewWillAppear(true)
		}
	}
	
	func shuffle<T>(_ array:inout [T]){
		
		var length = array.count
		
		for _  in array{
			
			/*Generating random number with length*/
			let random = arc4random_uniform(UInt32(length))
			/*Check before index of two elements not same*/
			if length-1 != Int(random){
				swap(&array[length-1], &array[Int(random)])
			}
			
			length -= 1
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		variantsList = [["Variable", "Constant", "Method", "Class"], ["Variable", "Constant", "Method", "Class"], ["Variable", "Constant", "Method", "Class"], ["Variable", "Constant", "Method", "Class"]]
		answersList = [0, 1, 2, 3]
		scoreTitle.isHidden = true
		scoreValue.isHidden = true
        scoreLetter.isHidden = true
        scorePercent.isHidden = true
		questionText.text=questionsList[questionNumber]
		var temp = variantsList[questionNumber]
        if questionNumber == 0 {
            backButton.isHidden = true
        }
        else {
            backButton.isHidden = false
        }
		var indicies = [0, 1, 2, 3]
		shuffle(&indicies)
		
//		for _ in 0...3 {
			//			while indicies.contains(j){
			//				j = Int(arc4random_uniform(4))
			//			}
//			let j = Int(arc4random_uniform(4))
//			indicies.append(j)
//		}
		item1.setTitle(temp[indicies[0]], for: UIControlState.normal)
		item2.setTitle(temp[indicies[1]], for: UIControlState.normal)
		item3.setTitle(temp[indicies[2]], for: UIControlState.normal)
		item4.setTitle(temp[indicies[3]], for: UIControlState.normal)
	}


}

