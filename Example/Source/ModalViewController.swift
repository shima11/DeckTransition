//
//  ModalViewController.swift
//  DeckTransition
//
//  Created by Harshil Shah on 15/10/16.
//  Copyright © 2016 Harshil Shah. All rights reserved.
//

import UIKit
import DeckTransition


class ModalViewController: UIViewController {

    let elastic: Float
    let dismiss: Float
    let factor: Float

    let elasticSlider = UISlider()
    let dismissSlider = UISlider()
    let factorSlider = UISlider()

    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()

    let button = UIButton()

    init(elastic: Float, dismiss: Float, factor: Float) {

        self.elastic = elastic
        self.dismiss = dismiss
        self.factor = factor

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresentationCapturesStatusBarAppearance = true
        
        view.backgroundColor = .white

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        label.textAlignment = .center
        label.text = "Modal VC"
        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true


        elasticSlider.minimumValue = 0
        elasticSlider.maximumValue = 300
        elasticSlider.addTarget(self, action: #selector(self.changeSlider1(slider:)), for: .valueChanged)

        dismissSlider.minimumValue = 0
        dismissSlider.maximumValue = 300
        dismissSlider.addTarget(self, action: #selector(self.changeSlider2(slider:)), for: .valueChanged)

        factorSlider.minimumValue = 0
        factorSlider.maximumValue = 1
        factorSlider.addTarget(self, action: #selector(self.changeSlider3(slider:)), for: .valueChanged)

        elasticSlider.value = elastic
        dismissSlider.value = dismiss
        factorSlider.value = factor
        label1.text = "elastic: \(elasticSlider.value)"
        label2.text = "dismiss: \(dismissSlider.value)"
        label3.text = "factor: \(factorSlider.value)"

        let stackView = UIStackView()
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(elasticSlider)
        stackView.addArrangedSubview(label2)
        stackView.addArrangedSubview(dismissSlider)
        stackView.addArrangedSubview(label3)
        stackView.addArrangedSubview(factorSlider)

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.frame = CGRect(origin: .zero, size: CGSize(width: 300, height: 200))

        let displayCenter = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        stackView.center = displayCenter

        view.addSubview(stackView)

        button.addTarget(self, action: #selector(self.viewWasTapped(sender:)), for: .touchUpInside)
        button.setTitle("Modal", for: UIControlState.normal)
        button.backgroundColor = UIColor.darkGray
        button.frame = CGRect(x: displayCenter.x - 60, y: UIScreen.main.bounds.height - 120, width: 120, height: 60)
        button.layer.cornerRadius = 12
//        button.clipsToBounds = true
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowRadius = 24
        button.layer.shadowOpacity = 0.3
        view.addSubview(button)
    }

    @objc func changeSlider1(slider: UISlider) {
        label1.text = "elastic: \(slider.value)"
    }
    @objc func changeSlider2(slider: UISlider) {
        label2.text = "dismiss: \(slider.value)"
    }
    @objc func changeSlider3(slider: UISlider) {
        label3.text = "factor: \(slider.value)"
    }

    @objc func viewWasTapped(sender: UIButton) {
        let modal = ModalViewController(elastic: elasticSlider.value, dismiss: dismissSlider.value, factor: factorSlider.value)
        let transitionDelegate = DeckTransitioningDelegate(
            isSwipeToDismissEnabled: true,
            presentDuration: nil,
            presentAnimation: nil,
            presentCompletion: nil,
            dismissDuration: nil,
            dismissAnimation: nil,
            dismissCompletion: nil,
            elasticThreshold: CGFloat(elasticSlider.value),
            dismissThreshold: CGFloat(dismissSlider.value),
            translationFactor: CGFloat(factorSlider.value)
        )
        modal.transitioningDelegate = transitionDelegate
        modal.modalPresentationStyle = .custom
        present(modal, animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
	
}
