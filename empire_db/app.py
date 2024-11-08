from flask import Flask, render_template, request, redirect, url_for

import mysql.connector

import os

from dotenv import load_dotenv

from markupsafe import escape

# Load environment variables

load_dotenv()

app = Flask(__name__)

# Database connection using environment variables

def get_db_connection():

    return mysql.connector.connect(

        host=os.getenv("DB_HOST"),

        user=os.getenv("DB_USER"),

        password=os.getenv("DB_PASSWORD"),

        database=os.getenv("DB_NAME")

    )

# Route to display table data

@app.route('/')

def index():

    conn = get_db_connection()

    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM Person")

    persons = cursor.fetchall()

    conn.close()

    return render_template('index.html', persons=persons)

# Route to handle form submission

@app.route('/add_person', methods=['POST'])

def add_person():

    # Escape user input to prevent XSS and use parameterized query to prevent SQL injection

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

# Start the Flask server with python3 app.py

if __name__ == '__main__':

    app.run(debug=True)
