# Standalone Tracker Application

A web-based tracker application to manage and generate Excel reports with customizable field selection.

## Features

- **Data Entry Form**: All 17 required fields including Customer, Date of Shipment, Salesforce ID, Jira ID, and more
- **CRUD Operations**: Add, Update, and Delete entries
- **Master Excel Storage**: All data stored in `tracker_master_data.xlsx`
- **Custom Report Generation**: Select specific fields to include in generated reports
- **Styled Excel Output**: Professional formatting with colored headers and proper fonts
- **Interactive UI**: Modern, responsive interface with form validation

## Installation

1. Install Python dependencies:
```bash
pip install -r requirements.txt
```

## Running the Application

1. Start the Flask backend server:
```bash
python app.py
```

2. Open `index.html` in your web browser (double-click the file or use a local server)

The application will be accessible at:
- Frontend: Open `index.html` in browser
- Backend API: http://127.0.0.1:5000

## Usage

### Adding an Entry
1. Fill in the required fields in the form
2. Click "Add Entry" button
3. Entry will be saved to the master Excel file

### Updating an Entry
1. Click on any row in the table to load the data into the form
2. Modify the fields as needed
3. Click "Update Entry" button

### Deleting an Entry
1. Click on a row in the table to select it
2. Click "Delete Entry" button
3. Confirm the deletion

### Generating Custom Reports
1. Click "Generate Excel" button
2. A modal will appear with all available fields
3. Select/deselect the fields you want in your report
4. Click "Generate" to download the Excel file
5. The report will have professional formatting with colored headers

## File Structure

```
Standalone Tracker/
├── app.py                          # Flask backend server
├── index.html                      # Frontend UI
├── requirements.txt                # Python dependencies
├── tracker_master_data.xlsx        # Master data storage (auto-generated)
└── tracker_report_YYYYMMDD_HHMMSS.xlsx  # Generated reports
```

## Fields

1. Customer (required)
2. Date of Shipment (date field, required)
3. Save File Library
4. Save File Name
5. Salesforce ID
6. Jira ID
7. Issue Description
8. Object Name
9. Object Type
10. Object Description with Version
11. Action Type
12. Downtime Required (Yes/No dropdown)
13. Special Instructions
14. Shipped By
15. Vendor Name (fixed: "Agilysys")
16. Destination Object Library Type (dropdown: Custom/Utility/Base)
17. File Transfer Link

## Technical Details

- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Backend**: Python Flask with CORS enabled
- **Excel Library**: openpyxl for Excel file operations
- **Styling**: Custom CSS with gradient backgrounds and modern design
- **Data Storage**: Excel-based (no database required)

## Notes

- Vendor Name is automatically set to "Agilysys" and is read-only
- Date fields use native HTML5 date picker
- All data persists in the master Excel file
- Generated reports include timestamps in filename
- Headers in generated Excel are styled with blue background and white text
