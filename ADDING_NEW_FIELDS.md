# How to Add New Fields to the Tracker

## Quick Guide
To add a new field, you only need to update ONE file: `app.py`

## Step-by-Step Instructions

### 1. Add Field to FIELD_LABELS Dictionary (app.py)

Find the `FIELD_LABELS` dictionary and add your new field in the appropriate position:

```python
FIELD_LABELS = {
    'id': 'ID',
    'originalId': 'Original ID',
    'lastModified': 'Last Modified',
    'customer': 'Customer',
    'servicePackVersion': 'Service Pack Version',
    'dateOfShipment': 'Date of Shipment',
    # ADD YOUR NEW FIELD HERE - example:
    # 'newFieldName': 'Display Label',
    'saveFileLibrary': 'Save File Library',
    # ... rest of fields
}
```

**Important:** The field key (e.g., 'newFieldName') must be in camelCase with no spaces.

### 2. Update the UI Form (index.html) - OPTIONAL

If you want the field in a specific location in the form, manually add it to the appropriate form-row in index.html.

**For text input:**
```html
<div class="form-group">
    <label for="newFieldName">Display Label:</label>
    <input type="text" id="newFieldName" maxlength="50">
</div>
```

**For date input:**
```html
<div class="form-group">
    <label for="newFieldName">Display Label:</label>
    <input type="date" id="newFieldName">
</div>
```

**For dropdown:**
```html
<div class="form-group">
    <label for="newFieldName">Display Label:</label>
    <select id="newFieldName">
        <option value="">Select...</option>
        <option value="Option1">Option 1</option>
        <option value="Option2">Option 2</option>
    </select>
</div>
```

### 3. Update getFormData() Function (index.html)

Add your field to the data object:

```javascript
function getFormData() {
    return {
        // ... existing fields
        newFieldName: document.getElementById('newFieldName').value,
        // ... rest of fields
    };
}
```

### 4. Update setFormData() Function (index.html)

Add your field to load data when editing:

```javascript
function setFormData(data) {
    // ... existing fields
    document.getElementById('newFieldName').value = data.newFieldName || '';
    // ... rest of fields
}
```

### 5. Add to Table Display (OPTIONAL)

If you want the field visible in the main table, update the table header and row generation in index.html.

### 6. Restart the Server

After making changes:
1. Stop the Flask server (Ctrl+C)
2. Delete the old `tracker_master_data.xlsx` file OR run a migration script
3. Restart: `python3 app.py`

## Example: Adding a "Priority" Field

### 1. In app.py:
```python
FIELD_LABELS = {
    'id': 'ID',
    'originalId': 'Original ID',
    'lastModified': 'Last Modified',
    'customer': 'Customer',
    'priority': 'Priority',  # NEW FIELD
    'servicePackVersion': 'Service Pack Version',
    # ... rest
}
```

### 2. In index.html form:
```html
<div class="form-group">
    <label for="priority">Priority:</label>
    <select id="priority">
        <option value="">Select...</option>
        <option value="High">High</option>
        <option value="Medium">Medium</option>
        <option value="Low">Low</option>
    </select>
</div>
```

### 3. In getFormData():
```javascript
priority: document.getElementById('priority').value,
```

### 4. In setFormData():
```javascript
document.getElementById('priority').value = data.priority || '';
```

That's it! The field will automatically be:
- ✅ Stored in Excel
- ✅ Generated in Excel reports
- ✅ Available for edit/update/delete
- ✅ Included in data reads

## Important Notes

- Field keys must match exactly across all files
- Field order in FIELD_LABELS determines Excel column order
- Always backup your data before major changes
- Test with a single entry before bulk operations
