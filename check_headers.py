import openpyxl

wb = openpyxl.load_workbook('tracker_master_data.xlsx')
ws = wb.active
headers = [cell.value for cell in ws[1]]
print('New headers:')
for i, h in enumerate(headers, 1):
    print(f'{i}. {h}')
