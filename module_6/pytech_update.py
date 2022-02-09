""" 
    Title: pytech_update.py
    Author: Grant Roberts
    Date: 2/8/2022
    Description: Test program for updating a document in the pytech collection
"""

""" import statements """
# Import MongoClient from pymongo
from pymongo import MongoClient

# Import certifi so you can get rid of the certificate errors
import certifi

# MongoDB connection string 
url = "mongodb+srv://admin:admin@cluster0.p89vo.mongodb.net/myFirstDatabase?retryWrites=true&w=majority"

# connect to the MongoDB cluster 
client = MongoClient(url, tlsCAFile=certifi.where())

# connect pytech database
db = client.pytech

# get the students collection 
students = db.students

# find all students in the collection 
student_list = students.find({})

# display message 
print("\n  -- DISPLAYING STUDENTS DOCUMENTS FROM find() QUERY --")

# loop over the collection and output the results 
for doc in student_list:
    print("  Student ID: " + doc["student_id"] + "\n  First Name: " + doc["first_name"] + "\n  Last Name: " + doc["last_name"] + "\n")

# update student_id 1007
result = students.update_one({"student_id": "1007"}, {"$set": {"last_name": "Baggins"}})

# find the updated student document 
thorin = students.find_one({"student_id": "1007"})

# display message
print("\n  -- DISPLAYING STUDENT DOCUMENT 1007 --")

# output the updated document to the terminal window
print("  Student ID: " + thorin["student_id"] + "\n  First Name: " + thorin["first_name"] + "\n  Last Name: " + thorin["last_name"] + "\n")

# exit message 
input("\n\n  End of program, press any key to continue...")