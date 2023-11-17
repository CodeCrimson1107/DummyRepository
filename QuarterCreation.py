import os

#print("String format :", os.getcwd())

base_dir = "//dalgrp01/RiskManagementGrpshare/Actuarial/ACY/"
quarter = "4Q23"
subfolders = ["01. Data", "02. Data Validation", "03. Accounting Files", "04. Audit Book", "05. Bootstrap"]
states = ["ARIZONA","ARKANSAS","ALABAMA","NSL","GEORGIA","ILLINOIS","INDIANA","MISSOURI",
            "MISSISSIPPI","NEW MEXICO","OHIO","OKLAHOMA","OREGON","SCAROLINA","TENNESSEE","TEXAS","UTAH","VIRGINIA","WISCONSIN", "PENNSYLVANIA", "MARYLAND"]

for state in states:
    path = os.path.normpath(os.path.join(base_dir, state, "RESERVERS", quarter))
    print(path)

 def createFolders(base_dir, quarter, subfolders, states):
    # build file path This loops through each states and makes the new quarter folder
    for state in states:
        path = os.path.normpath(os.path.join(base_dir, state, "RESERVERS", quarter))
        os.makedirs(path, exist_ok = True) 
        
        # change directory to new quarter directory
        os.chdir(path)
        
        # now create the 5 sub directories in the quarter directory
        for subfolder in subfolders:
            os.makedirs(subfolder, exist_ok = True)
