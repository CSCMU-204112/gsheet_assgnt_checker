#!/usr/bin/env python3
#import gdata.docs.service
import sys
import json
import gspread
from oauth2client.client import SignedJwtAssertionCredentials

# print r


def mark_inactive():
    i = 0
    for line in sys.stdin:
        i += 1
        #print("i = %d" %(i))
        #output = ""
        line = line.rstrip('\n')
        #nums = list(map(int,line.split(" ")))
        nums = list(line.split(" "))
        # print nums
        if i == 1:
            gSheetKey = nums[0]
            try:
                json_key = json.load(
                    open('/home/kittipitch/private_scripts/credential/204scoresheet-541738831dfe.json'))
                scope = ['https://spreadsheets.google.com/feeds']
                credentials = SignedJwtAssertionCredentials(
                    json_key['client_email'], bytes(json_key['private_key'], 'utf-8'), scope)
                gc = gspread.authorize(credentials)
                gSheetKey = nums[0]
                wb = gc.open_by_key(gSheetKey)
                worksheet = wb.get_worksheet(0)
            except:
                print("Cannot open the sheet with key specified ", gSheetKey,
                      " (probably an access right issue), breaking off")
                break

            try:
                activeTitleCell = worksheet.find('active')
                activeCol = activeTitleCell.col
#                print("col = ", activeCol)
            except:
                print("Problem with finding active column ")
                break
            continue

        if i > 1:
            stuId = nums[0]
            stuId.strip()
            print("stuId:", stuId)
            try:
                row = worksheet.find(stuId).row
#                print("col = ", activeCol," row = ", row)
                worksheet.update_cell(row, activeCol, 0)
            except:
                print("Cannot find student with the ID ", stuId)

mark_inactive()
