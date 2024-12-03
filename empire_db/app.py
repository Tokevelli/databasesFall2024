from flask import Flask, render_template, request, redirect, url_for
import mysql.connector
import os
from dotenv import load_dotenv
from markupsafe import escape

# Load environment variables
load_dotenv()

app = Flask(__name__)

# Database connection function
def get_db_connection():
    return mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME")
    )

# Existing CRUD routes for Person table
@app.route('/')
def index():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Person")
    persons = cursor.fetchall()
    conn.close()
    return render_template('index.html', persons=persons)

@app.route('/add_person', methods=['POST'])
def add_person():
    first_name = escape(request.form['first_name'])
    last_name = escape(request.form['last_name'])
    age = request.form['age']
    rank_id = request.form['rank_id']
    specialization_id = request.form['specialization_id']

    location_id = request.form['location_id']
    start_date = request.form['start_date']
    end_date = request.form['end_date']
    
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO Person (FirstName, LastName, Age, RankID, SpecializationID) VALUES (%s, %s, %s, %s, %s)",
        (first_name, last_name, age, rank_id, specialization_id)
    )
    person_id = cursor.lastrowid
   
    cursor.execute(
        "INSERT INTO Assignment (PersonID, LocationID, StartDate, EndDate) VALUES (%s, %s, %s, %s)",
        (person_id, location_id, start_date, end_date)
    )

    conn.commit()
    conn.close()
    return redirect(url_for('index'))

@app.route('/edit_person/<int:person_id>', methods=['GET', 'POST'])
def edit_person(person_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    if request.method == 'POST':
        first_name = escape(request.form['first_name'])
        last_name = escape(request.form['last_name'])
        age = request.form['age']
        rank_id = request.form['rank_id']
        specialization_id = request.form['specialization_id']
        
        cursor.execute(
            "UPDATE Person SET FirstName = %s, LastName = %s, Age = %s, RankID = %s, SpecializationID = %s WHERE PersonID = %s",
            (first_name, last_name, age, rank_id, specialization_id, person_id)
        )
        conn.commit()
        conn.close()
        return redirect(url_for('index'))
    else:
        cursor.execute("SELECT * FROM Person WHERE PersonID = %s", (person_id,))
        person = cursor.fetchone()
        conn.close()
        return render_template('edit_person.html', person=person)

@app.route('/delete_person/<int:person_id>', methods=['POST'])
def delete_person(person_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Person WHERE PersonID = %s", (person_id,))
    conn.commit()
    conn.close()
    return redirect(url_for('index'))

# New routes for Assignment table (many-to-many relationship)

# List all people
@app.route('/people')
def list_people():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Person")
    people = cursor.fetchall()
    conn.close()
    return render_template('people.html', people=people)

# List all assignments for a specific person
@app.route('/person_assignments/<int:person_id>')
def person_assignments(person_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Person WHERE PersonID = %s", (person_id,))
    person = cursor.fetchone()
    cursor.execute("""
        SELECT Assignment.AssignmentID, Location.PlanetName, Assignment.StartDate, Assignment.EndDate, Assignment.LocationID
        FROM Assignment
        JOIN Location ON Assignment.LocationID = Location.LocationID
        WHERE Assignment.PersonID = %s
    """, (person_id,))
    assignments = cursor.fetchall()
    conn.close()
    return render_template('person_assignments.html', person=person, assignments=assignments)

# List all people assigned to a specific location
@app.route('/location_assignments/<int:location_id>')
def location_assignments(location_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Location WHERE LocationID = %s", (location_id,))
    location = cursor.fetchone()
    cursor.execute("""
        SELECT Person.FirstName, Person.LastName, Assignment.StartDate, Assignment.EndDate 
        FROM Assignment
        JOIN Person ON Assignment.PersonID = Person.PersonID
        WHERE Assignment.LocationID = %s
    """, (location_id,))
    people = cursor.fetchall()
    conn.close()
    return render_template('location_assignments.html', location=location, people=people)

# Add a new assignment
@app.route('/add_assignment', methods=['GET', 'POST'])
def add_assignment():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    if request.method == 'POST':
        person_id = request.form['person_id']
        location_id = request.form['location_id']
        start_date = request.form['start_date']
        end_date = request.form['end_date']
        cursor.execute("""
            INSERT INTO Assignment (PersonID, LocationID, StartDate, EndDate)
            VALUES (%s, %s, %s, %s)
        """, (person_id, location_id, start_date, end_date))
        conn.commit()
        conn.close()
        return redirect(url_for('list_people'))
    else:
        cursor.execute("SELECT * FROM Person")
        people = cursor.fetchall()
        cursor.execute("SELECT * FROM Location")
        locations = cursor.fetchall()
        conn.close()
        return render_template('add_assignment.html', people=people, locations=locations)

# Delete Assignment Function
@app.route('/delete_assignment/<int:assignment_id>', methods=['POST'])
def delete_assignment(assignment_id):
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("DELETE FROM Assignment WHERE AssignmentID = %s", (assignment_id,))
    conn.commit()
    conn.close()
    return redirect(url_for('list_people'))  # Redirect to the page listing all assignments or people

# Edit Assignment
@app.route('/edit_assignment/<int:assignment_id>', methods=['GET', 'POST'])
def edit_assignment(assignment_id):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    if request.method == 'POST':
        start_date = request.form['start_date']
        end_date = request.form['end_date']
        cursor.execute("""
            UPDATE Assignment 
            SET StartDate = %s, EndDate = %s 
            WHERE AssignmentID = %s
        """, (start_date, end_date, assignment_id))
        conn.commit()
        conn.close()
        return redirect(url_for('list_people'))  # Redirect to a relevant page
    else:
        cursor.execute("SELECT * FROM Assignment WHERE AssignmentID = %s", (assignment_id,))
        assignment = cursor.fetchone()
        conn.close()
        return render_template('edit_assignment.html', assignment=assignment)


# Run Flask application
if __name__ == '__main__':
    app.run(debug=True)

