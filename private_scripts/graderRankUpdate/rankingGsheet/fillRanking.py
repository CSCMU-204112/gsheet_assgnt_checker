#!updater/Scripts/python

import sys
import fileinput
import json
import gspread

from datetime import datetime
from oauth2client.client import SignedJwtAssertionCredentials

# print r


def read_input(filename):
    i = 0

    for line in fileinput.input(filename, openhook=fileinput.hook_encoded('utf-8')):
        i += 1
        #print("i = %d" %(i))
        #output = ""
        line = line.rstrip('\n')
        #nums = list(map(int,line.split(" ")))
        # print nums
        if i == 1:
            try:
                gSheetKey = line 

                json_key = json.load(
                    open('/home/kittipitch/private_scripts/credential/204scoresheet-541738831dfe.json'))
                scope = ['https://spreadsheets.google.com/feeds']
                credentials = SignedJwtAssertionCredentials(
                    json_key['client_email'], bytes(json_key['private_key'], 'utf-8'), scope)
                gc = gspread.authorize(credentials)

                wb = gc.open_by_key(gSheetKey)
#                worksheet = wb.get_worksheet(0)
                worksheet = wb.worksheet('score')
            except:
                print("Unexpected error:", sys.exc_info()[0])
                print("Cannot open the sheet with key specified ", gSheetKey,
                      " (probably an access right issue), breaking off")
                break
#           print colval
        if i > 1 and len(line.strip()) > 0:
            row = i + 1
            cells = line.split(',')
            cell_count = len(cells)
            stuId = cells[0]
            try:
                row = worksheet.find(stuId).row
            except:
                print("Unexpected error for id", stuId, ":", sys.exc_info()[0])
                break
            start_col_str = colnum_string(1) + str(row)
            end_col_str = colnum_string(cell_count) + str(row)

            try:
                cell_list = worksheet.range(start_col_str + ':' + end_col_str)
                j = 0
                
                for cell in cell_list:
                    cell.value = cells[j]
                    j += 1

                worksheet.update_cells(cell_list)
                print("Updated row = %d with id = %s" % (row, stuId))
            except:
                print("Unexpected row update error for id", stuId, ":", sys.exc_info()[0])
                print("Cannot update row = %d with id = %s" % (row, stuId))
    curr_date = str(datetime.now())
    worksheet.update_cell(1, 3, curr_date)
        

def colnum_string(n):
    div = n
    string = ""
    while div > 0:
        module = (div - 1) % 26
        string = chr(65 + module) + string
        div = int((div - module) / 26)
    return string


if __name__ == "__main__":
    [filename] = sys.argv[1:]
    read_input(filename)
