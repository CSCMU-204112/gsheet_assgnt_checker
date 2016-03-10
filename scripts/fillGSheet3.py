#!/usr/bin/env python3
#import gdata.docs.service
import sys
import json
import gspread
from oauth2client.client import SignedJwtAssertionCredentials
from datetime import datetime

# visit https://gspread.readthedocs.org/en/latest/ for more details on gspread
# print r

def read_input():
    i = 0
    row = None
    col = None
    id_fill = dict()
    for line in sys.stdin:
        i += 1
        #print("i = %d" %(i))
        #output = ""
        line = line.rstrip('\n')
        #nums = list(map(int,line.split(" ")))
        nums = list(line.split())
        # print nums
        if i == 1:
            date = nums[0]
        if i == 2:
            course = nums[0]
        if i == 3:
            gSheetKey = nums[0]
        if i == 4:
            sheet_num = nums[0]
            start_fill_row = nums[1]
            try:
                json_key = json.load(
                    open('/home/kk/private_scripts/credential/204scoresheet-541738831dfe.json'))
                # open('/home/kittipitch/private_scripts/credential/204scoresheet-541738831dfe.json'))
                scope = ['https://spreadsheets.google.com/feeds']
                credentials = SignedJwtAssertionCredentials(
                    json_key['client_email'], bytes(json_key['private_key'], 'utf-8'), scope)
                gc = gspread.authorize(credentials)
                wb = gc.open_by_key(gSheetKey)
                worksheet = wb.get_worksheet(int(sheet_num))
            except:
                print("Cannot open the sheet with key specified ", gSheetKey,
                      " (probably an access right issue), breaking off")
                break
        if i == 5:
            section = nums[0]
        if i == 6:
            assgn = nums[0]
            fill_mode = nums[1]
            print(assgn)
            try:
                assgnCell = worksheet.find(assgn)
                assgnCol = assgnCell.col

                row_count = worksheet.row_count
                colStart = worksheet.get_addr_int(start_fill_row, assgnCol)
                colEnd = worksheet.get_addr_int(row_count, assgnCol)
                #print("colStart =", colStart)
                #print("colEnd =", colEnd)
                assgnColCells = worksheet.range(colStart + ':' + colEnd)
                print("filling range", colStart + ':' + colEnd)
                #print("col = ", assgnCol)
            except:
                print()
                print(datetime.now(), course, section,
                      " - Problem with finding assignment ", assgn)
        if i > 6:
            fileName = nums[0]
            textFill = nums[1]
            if course == "204100":
                stuId = fileName.split("_")[0][-9:]
            else:
                stuId = fileName.split(".")[0][-9:]
            # print "|"+stuId+"|"
            id_fill[stuId] = textFill
            # print type(stuId)

    try:

        stuId, textFill = id_fill.popitem()
        id_cell = worksheet.find(stuId)
        id_fill[stuId] = textFill

        stuIdCol = id_cell.col
        colStart = worksheet.get_addr_int(start_fill_row, stuIdCol)
        colEnd = worksheet.get_addr_int(row_count, stuIdCol)

        idColCells = worksheet.range(colStart + ':' + colEnd)

        for i in range(len(idColCells)):
            stuId = idColCells[i].value
            textFill = id_fill.get(stuId)

            if fill_mode == "RECHECK" and len(stuId) == 9 and stuId.isdigit():
                assgnColCells[i].value = ""
                #print("erasing", stuId)

            if textFill is not None:
                assgnColCells[i].value = textFill
                #print("filling", stuId, "with", textFill)

        # print "col = ", assgnCol," row = ",row
        worksheet.update_cells(assgnColCells)
    except:
        print(datetime.now(), course, section, assgn,
              "- Cannot find student with the ID", stuId)

read_input()
