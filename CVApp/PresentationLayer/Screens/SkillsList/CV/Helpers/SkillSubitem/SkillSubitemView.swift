//
//  SkillSubitemView.swift
//  CVApp
//
//  Created by Oleksandr Orlov on 18/4/20.
//  Copyright © 2020 Oleksandr Orlov. All rights reserved.
//

import UIKit

class SkillSubitemView: InitView {
  
  // MARK: - UI elements
   
   private let listItemSymbolLabel = UILabel()
   let titleLabel = UILabel()
   
   // MARK: - Setup
   
   override func setup() {
     super.setup()
     setupListItemSymbolLabel()
     setupTitleLabel()
   }
   
   // MARK: - AutoLayout
   
   override func autoLayout() {
     super.autoLayout()
     addSubviews([
       listItemSymbolLabel,
       titleLabel
     ])
     autoLayoutListItemSymbolLabel()
     autoLayoutTitleLabel()
   }
   
   // MARK: - Appearance
   
   override func setAppearance(_ appearance: Appearance) {
     super.setAppearance(appearance)
     setSelf(appearance: appearance)
     setListItemSymbolLabel(appearance: appearance)
     setTitleLabel(appearance: appearance)
   }
   
   // MARK: - Setup self
   
   private func setSelf(appearance: Appearance) {
     backgroundColor = appearance.background.primary
   }
   
   // MARK: - Setup listItemSymbolLabel
   
   private func setupListItemSymbolLabel() {
     listItemSymbolLabel.text = "-"
     listItemSymbolLabel.numberOfLines = 1
     listItemSymbolLabel.setContentHuggingPriority(.required, for: .horizontal)
     listItemSymbolLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
   }
   
   private func setListItemSymbolLabel(appearance: Appearance) {
     listItemSymbolLabel.textColor = appearance.text.primary
   }
   
   private func autoLayoutListItemSymbolLabel() {
     listItemSymbolLabel.snp.makeConstraints { make in
       make.leading.equalToSuperview().offset(36)
       make.top.equalTo(titleLabel)
     }
   }
   
   // MARK: - Setup titleLabel
   
   private func setupTitleLabel() {
     titleLabel.numberOfLines = 0
     titleLabel.font = .font(ofSize: 16)
   }
   
   private func setTitleLabel(appearance: Appearance) {
     titleLabel.textColor = appearance.text.primary
   }
   
   private func autoLayoutTitleLabel() {
     titleLabel.snp.makeConstraints { make in
       make.leading.equalTo(listItemSymbolLabel.snp.trailing).offset(5)
       make.top.equalToSuperview().offset(7)
       make.bottom.equalToSuperview().inset(15)
       make.trailing.equalToSuperview().inset(15)
     }
   }
}
