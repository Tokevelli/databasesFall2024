from flask import Flask, render_template, request

app = Flask(__name__, static_folder='static')

# Route to render the form page
@app.route('/')
def form():
    return app.send_static_file('form.html')

# Route to render the table with dynamic data from the form
@app.route('/display')
def display():
    # Get values from URL parameters
    first_name = request.args.get('first_name')
    last_name = request.args.get('last_name')
    age = request.args.get('age')
    
    # Table data: first two rows hard-coded, third from form data
    rows = [
        ["Anakin", "Skywalker", "41"],
        ["Jane", "Doe", "24"],
        [first_name, last_name, age]  # New row populated from form input
    ]
    return render_template('table_dynamic.html', rows=rows)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)

