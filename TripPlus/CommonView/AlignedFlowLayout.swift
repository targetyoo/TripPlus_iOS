//
//  AlignedFlowLayout.swift
//  TripPlus
//
//  Created by 유대상 on 1/19/25.
//

import Foundation
import UIKit

class RightAlignedFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributesArray = super.layoutAttributesForElements(in: rect) else { return nil }

        // 각 줄별로 오른쪽 정렬
        var currentY: CGFloat = -1
        var lineAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in attributesArray {
            if attributes.representedElementCategory != .cell { continue }
            
            if currentY != attributes.frame.origin.y {
                alignCellsToRight(lineAttributes)
                lineAttributes.removeAll()
                currentY = attributes.frame.origin.y
            }
            lineAttributes.append(attributes)
        }
        alignCellsToRight(lineAttributes)
        
        return attributesArray
    }
    
    private func alignCellsToRight(_ attributes: [UICollectionViewLayoutAttributes]) {
        guard let collectionView = collectionView, !attributes.isEmpty else { return }
        
        let collectionViewWidth = collectionView.bounds.width
        let totalWidth = attributes.reduce(0) { $0 + $1.frame.width }
        let totalSpacing = minimumInteritemSpacing * CGFloat(attributes.count - 1)

        // 마지막 셀의 크기 확인
//        let lastCellWidth: CGFloat = attributes.last?.frame.width ?? 0
//        let offsetX = collectionViewWidth - totalWidth - totalSpacing - sectionInset.right - lastCellWidth - minimumInteritemSpacing // 마지막 셀의 너비만큼 공간 비우기
//        
//        var x = offsetX
//        for (index, attribute) in attributes.enumerated() {
//            attribute.frame.origin.x = x
//            x += attribute.frame.width + minimumInteritemSpacing
//        }

        let offsetX = collectionViewWidth - totalWidth - totalSpacing - sectionInset.right
        
        var x = offsetX
        for attribute in attributes {
            attribute.frame.origin.x = x
            x += attribute.frame.width + minimumInteritemSpacing
        }
    }
}
