
//
//  CommonConstValue.swift
//  TripPlus
//
//  Created by 유대상 on 1/20/25.
//


import CoreFoundation
import UIKit

struct DesignSystem{
    private init() {}

    struct Common{
        private init() {}
        static let leading_Offset: CGFloat = 15.0
        static let trailing_Offset: CGFloat = -15.0
        static let icon_size: CGFloat = 24.0
    }
    
    struct CardCollection{
        private init() {}
        static let thumbnail_cornerRadius: CGFloat = 14.0
        static let thumbnail_name_font: UIFont = UIFont(name: "PRETENDARD-Regular", size: 16)!
        static let thumbnail_name_textColor: UIColor = UIColor(named: "grayA")!
        static let thumbnail_name_leading: CGFloat = 13.0
        static let thumbnail_name_trailing: CGFloat = 13.0

    }
    
    struct ListCollection{
        private init() {}
        
        static let index_textColor: UIColor = UIColor(named: "grayA")!
        static let index_font:UIFont = UIFont(name: "PRETENDARD-Medium", size: 20)!
        static let index_width: CGFloat = 35.0
        
        static let title_textColor: UIColor = UIColor(named: "grayA")!
        static let title_font:UIFont = UIFont(name: "PRETENDARD-Regular", size: 16)!
        
        static let location_textColor: UIColor = UIColor(named: "grayB")!
        static let location_font:UIFont = UIFont(name: "PRETENDARD-Light", size: 12)!
        
        static let body_textColor: UIColor = UIColor(named: "grayA")!
        static let body_font:UIFont = UIFont(name: "PRETENDARD-Light", size: 12)!
        
        static let thumbnail_Height: CGFloat = 100.0
        static let thumbnail_cornerRadius: CGFloat = 7.0
        static let thumbnail_num_font: UIFont = UIFont(name: "PRETENDARD-Light", size: 12)!
        static let thumbnail_num_textColor: UIColor = UIColor(named: "grayA")!
    }
    
    struct Button{
        private init() {}
        //TODO: Constraint값도 공통 값이므로 추가 필요(Bottom - 50, leading trailing - 15)
        
        static let height: CGFloat = 50.0
        static let cornerRadius: CGFloat = 14.0
        static let font: UIFont = UIFont(name: "PRETENDARD-REGULAR", size: 16.0)!
        
        static let confirm_BackgroundColor: UIColor = UIColor(named: "tripGreen")!
        static let confirm_FontColor: UIColor = UIColor(named: "grayD")!
        
        static let close_BackgroundColor: UIColor = UIColor(named: "grayC")!
        static let close_FontColor: UIColor = UIColor(named: "grayA")!
    }
    
    struct Calendar{
        private init() {}
        static let button_font: UIFont = UIFont(name: "PRETENDARD-Light", size: 12.0)!
        static let button_Height: CGFloat = 36
        static let button_CornerRadius: CGFloat = 7.0
        static let button_Selected_BorderWidth: CGFloat = 1.0
        static let button_Selected_BorderColor: UIColor = UIColor(named: "tripGreen")!
        static let button_Selected_BackgroundColor: UIColor = UIColor(named: "tripGreen")!.withAlphaComponent(0.25)
        static let button_Unselected_BackgroundColor: UIColor = UIColor(named: "grayC")!
        static let button_Unselected_FontColor: UIColor = UIColor(named: "grayB")!
        
        static let day_selectWidth: CGFloat = 20.0
        static let day_selectHeight: CGFloat = 22.0
        static let day_cornerRadius: CGFloat = 6.0
        
        static let font: UIFont =  UIFont(name: "PRETENDARD-REGULAR", size: 16.0)!
        static let thisMonth_fontColor: UIColor =  UIColor(named: "grayA")!
        static let notThisMonth_fontColor: UIColor =  UIColor(named: "grayB")!
        static let todayColor: UIColor = UIColor(named: "tripOrange")!
        static let selected_BackgroundColor: UIColor = UIColor(named: "tripGreen")!
        static let selected_FontColor: UIColor = UIColor(named: "grayD")!
        static let selected_range_BackgroundColor: UIColor = UIColor(named: "tripGreen")!.withAlphaComponent(0.5)
    }
    
    struct Badge{
        private init() {}
        static let cornerRadius: CGFloat = 14.0
        static let height: CGFloat = 36.0
    }
}


let RIGHTALIGHNEDCELL_ITEM_RADIUS: CGFloat = 14.0
