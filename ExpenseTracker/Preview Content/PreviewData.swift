//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Satyam Shivhare on 01/04/23.
//

import Foundation

var transanctionPreviewData = Transanction(id: 1, date: "91/24/2022", institution: "Desjardins", account: "Visa Desjardins",
                                          merchant: "Apple",
                                          amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transanctionListPreviewData = [Transanction](repeating: transanctionPreviewData, count: 10)
