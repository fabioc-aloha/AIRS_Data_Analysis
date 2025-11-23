import pandas as pd
import json

# Read the CSV file - row 1 has Q numbers, row 3 has question text
with open('data/AIRS---AI-Readiness-Scale-labels.csv', 'r', encoding='utf-8') as f:
    lines = [f.readline() for _ in range(3)]

# Parse row 1 (Q numbers) and row 3 (question text)
q_numbers = lines[0].strip().split(',')
question_types = lines[1].strip().split(',')
question_texts = []

# Parse row 3 carefully - it has quoted strings with commas inside
import csv
with open('data/AIRS---AI-Readiness-Scale-labels.csv', 'r', encoding='utf-8') as f:
    reader = csv.reader(f)
    next(reader)  # skip row 1
    next(reader)  # skip row 2
    question_texts = next(reader)  # row 3

# Create mapping from Q number to question text
q_to_text = {}
for i, q in enumerate(q_numbers):
    if q.startswith('Q') and i < len(question_texts):
        # Extract the actual question part (after the | if present)
        full_text = question_texts[i]
        if ' | ' in full_text:
            q_to_text[q] = full_text.split(' | ', 1)[1]
        else:
            q_to_text[q] = full_text

# Load the item selection
with open('data/airs_12item_selection.json', 'r') as f:
    selection = json.load(f)

# Map item codes to Q numbers
item_to_q = {
    'PE2': 'Q5', 'EE1': 'Q6', 'SI1': 'Q8', 'FC1': 'Q10',
    'HM2': 'Q13', 'PV2': 'Q15', 'HB2': 'Q17', 'VO1': 'Q18',
    'TR2': 'Q21', 'EX1': 'Q22', 'ER2': 'Q26', 'AX1': 'Q27'
}

# Extract construct order and selected items
constructs = ['PE', 'EE', 'SI', 'FC', 'HM', 'PV', 'HB', 'VO', 'TR', 'EX', 'ER', 'AX']

print('\n=== SELECTED ITEMS (12) ===\n')
print('| Construct | Item | Question Wording |')
print('|-----------|------|------------------|')
for construct in constructs:
    item_code = selection[construct]['selected_item']
    q_num = item_to_q[item_code]
    question_text = q_to_text.get(q_num, 'NOT FOUND')
    print(f'| {construct} | {item_code} | {question_text} |')

# Now get the BI items (Q29-Q32)
print('\n\n=== BEHAVIORAL INTENTION ITEMS (4) ===\n')
print('| Item | Question Wording |')
print('|------|------------------|')
for i, q_num in enumerate(['Q29', 'Q30', 'Q31', 'Q32'], 1):
    question_text = q_to_text.get(q_num, 'NOT FOUND')
    print(f'| BI{i} | {question_text} |')
