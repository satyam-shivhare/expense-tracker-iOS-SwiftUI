//
//  TransanctionRow.swift
//  ExpenseTracker
//
//  Created by Satyam Shivhare on 01/04/23.
//

import Foundation
import SwiftUI
import SwiftUIFontIcon


struct TransanctionRow: View{
    
    var transanction: Transanction
    
    var body: some View{
        HStack(spacing : 20){
            
            RoundedRectangle(cornerRadius: 20 , style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: transanction.icon), fontsize: 24 , color: Color.icon)
                }
            
            VStack(alignment: .leading, spacing: 6 ){
                //Mark : Transanction Merchant
                Text(transanction.merchant)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                //Mark : Transanction Category
                Text(transanction.category)
                    .font(.footnote)
                    .opacity(  0.7)
                    .lineLimit(1)
                
                //Mark : Transanction Date
                Text(transanction.dateParsed , format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            //Mark : Transanction Amount
            Text(transanction.signedAmount, format: .currency(code: "usd"))
                .fontWeight(.bold)
                .foregroundColor(transanction.type == TransanctionType.credit.rawValue ? Color.text : .primary)
        }
        .padding([.top , .bottom ],8)
    }
}

struct TransanctionRow_Previews: PreviewProvider{
    static var previews: some View{
        TransanctionRow(transanction:  transanctionPreviewData)
    }
}
