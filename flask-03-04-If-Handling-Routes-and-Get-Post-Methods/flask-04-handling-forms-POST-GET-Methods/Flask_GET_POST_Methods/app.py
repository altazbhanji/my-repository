# Import Flask modules
from flask import Flask, render_template, request

# Create an object named app
app = Flask(__name__)


# create a function named "lcm" which calculates a least common multiple values of two numbers.
def lcm(num1,num2):
    common_multiplications = [] 
    for i in range(max(num1, num2),num1*num2+1):
        if i%num1==0 and i%num2==0:
           common_multiplications.append(i) 
    return min(common_multiplications)


# Create a function named `index` which uses template file named `index.html` 
# send two numbers as template variable to the app.py and assign route of no path ('/')
@app.route('/')
def index():
    return render_template('index.html')


# calculate sum of them using "lcm" function, then sent the result to the 
# "result.hmtl" file and assign route of path ('/calc'). 
# When the user comes directly "/calc" path, "Since this is a GET request, LCM has not been calculated" string returns to them with "result.html" file
@app.route('/calc', methods=['GET', 'POST'])
def calc():

    if request.method == 'POST':
        num1 = int(request.form.get("number1"))
        num2 = int(request.form.get("number2"))

        my_lcm = lcm(num1, num2)
        return render_template('result.html', lcm=my_lcm, result1=num1, result2=num2, developer_name='Altaz')
    else: # if this is a GET request - user comes directly
        return render_template('result.html', developer_name='Altaz')


# Add a statement to run the Flask application which can be debugged.
if __name__ == '__main__':
    app.run(debug=True)