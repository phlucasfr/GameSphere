//
//  CaptionTextView.swift
//  GameSphere
//
//  Created by Phelipe Lucas on 16/06/23.
//

import UIKit
import SnapKit

class CaptionTextView: UITextView {
    
    //MARK: - Properties
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gameSphereBrown
        label.text = "What game are you up to play today?"
        return label
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configTextView()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTextInputChange),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func handleTextInputChange(){
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    //MARK: - Helpers
    private func configTextView() {
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        textColor = .gameSphereBlack
        
        setupPlaceholderLabel()
    }
    
    private func setupPlaceholderLabel() {
        addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(4)
        }
    }
    
}

