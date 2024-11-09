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

# Read: Display table data

@app.route('/')

def index():

    conn = get_db_connection()

    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM Person")

    persons = cursor.fetchall()

    conn.close()

    return render_template('index.html', persons=persons)

# Create: Handle form submission for new data

@app.route('/add_person', methods=['POST'])

def add_person():

    first_name = escape(request.form['first_name'])

    last_name = escape(request.form['last_name'])

    age = request.form['age']

    rank_id = request.form['rank_id']

    specialization_id = request.form['specialization_id']

    

    conn = get_db_connection()

    cursor = conn.cursor()

    cursor.execute(

        "INSERT INTO Person (FirstName, LastName, Age, RankID, SpecializationID) VALUES (%s, %s, %s, %s, %s)",

        (first_name, last_name, age, rank_id, specialization_id)

    )

    conn.commit()

    conn.close()

    return redirect(url_for('index'))

# Update: Load form with pre-filled data for editing

@app.route('/edit_person/<int:person_id>', methods=['GET', 'POST'])

def edit_person(person_id):

    conn = get_db_connection()

    cursor = conn.cursor(dictionary=True)

    

    if request.method == 'POST':

        # Update data

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

        # Load data for pre-filling the form

        cursor.execute("SELECT * FROM Person WHERE PersonID = %s", (person_id,))

        person = cursor.fetchone()

        conn.close()

        return render_template('edit_person.html', person=person)

# Delete: Remove a specific row

@app.route('/delete_person/<int:person_id>', methods=['POST'])

def delete_person(person_id):

    conn = get_db_connection()

    cursor = conn.cursor()

    cursor.execute("DELETE FROM Person WHERE PersonID = %s", (person_id,))

    conn.commit()

    conn.close()

    return redirect(url_for('index'))

# Start the Flask server

if __name__ == '__main__':

    app.run(debug=True)


