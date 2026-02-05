# Standalone Tracker Application

A web-based tracker application to manage and generate Excel reports with customizable field selection.

## Features

- **Data Entry Form**: All 17 required fields including Customer, Date of Shipment, Salesforce ID, Jira ID, and more
- **CRUD Operations**: Add, Update, and Delete entries
- **Master Excel Storage**: All data stored in `tracker_master_data.xlsx`
- **Custom Report Generation**: Select specific fields to include in generated reports
- **Styled Excel Output**: Professional formatting with colored headers and proper fonts
- **Interactive UI**: Modern, responsive interface with form validation
- **User Management**: Manage users for the "Shipped By" field

## Installation

1. Clone the repository:
```bash
git clone https://github.com/lillysamuthirapandian/standalone-tracker.git
cd standalone-tracker
```

2. Create a virtual environment (recommended):
```bash
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

3. Install Python dependencies:
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
1. Click "Generate Excel" button to generate a full list
2. Or click the download icon (⬇) next to any entry to generate a custom report
3. A modal will appear with all available fields
4. Select/deselect the fields you want in your report
5. Click "Generate" to download the Excel file

## File Structure

```
standalone-tracker/
├── app.py                          # Flask backend server
├── index.html                      # Frontend UI
├── requirements.txt                # Python dependencies
├── check_headers.py                # Utility to check Excel headers
├── migrate_excel.py                # Migration script for Excel data
├── migrate_field.py                # Helper to add new fields
├── ADDING_NEW_FIELDS.md           # Guide for adding new fields
├── tracker_master_data.xlsx        # Master data storage (auto-generated)
└── users_master_data.xlsx          # User data (auto-generated)
```

## Fields

1. Customer (required)
2. Date of Shipment (date field, required)
3. Save File Library
4. Save File Name
5. Salesforce ID
6. Jira ID
7. Issue Description
8. Object Name (supports multiple entries)
9. Object Type (supports multiple entries)
10. Object Description with Version (supports multiple entries)
11. Action Type (supports multiple entries)
12. Downtime Required (Yes/No dropdown, supports multiple entries)
13. Special Instructions (supports multiple entries)
14. Shipped By (from User Management)
15. Vendor Name (fixed: "Agilysys")
16. Destination Object Library Type (dropdown: Custom/Utility/Base, supports multiple entries)
17. File Transfer Link

## Technical Details

- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Backend**: Python Flask with CORS enabled
- **Excel Library**: openpyxl for Excel file operations
- **Styling**: Custom CSS with modern gray/neutral theme
- **Data Storage**: Excel-based (no database required)

## Notes

- Vendor Name is automatically set to "Agilysys" and is read-only
- Date fields use native HTML5 date picker
- All data persists in the master Excel file
- Generated reports include timestamps in filename
- Headers in generated Excel are styled with blue background and white text
- Supports multiple object entries per tracker entry

## Contributing

For instructions on adding new fields, see [ADDING_NEW_FIELDS.md](ADDING_NEW_FIELDS.md)

## License

This project is proprietary and belongs to Agilysys.
