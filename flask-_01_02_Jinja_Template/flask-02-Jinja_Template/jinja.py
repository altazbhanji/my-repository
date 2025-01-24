from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def head():
    return render_template("index.html", number1=10, number2=20)

@app.route("/<string:num1>/<string:num2>")
def numbers(num1, num2):
    return render_template("index.html", number1=num1, number2=num2)

@app.route("/sum/<string:first>/<string:second>")
def sum(first, second):
    if first.isdigit() and second.isdigit():
        num1 = int(first)
        num2 = int(second)
        numsum = num1 + num2
        return render_template("body.html", value1=num1, value2=num2, sum=numsum)
    else:
        return "Poorly formatted URL"



if __name__== "__main__":
    app.run(debug=True, port=5000)
    # app.run(host= '0.0.0.0', port=8081)