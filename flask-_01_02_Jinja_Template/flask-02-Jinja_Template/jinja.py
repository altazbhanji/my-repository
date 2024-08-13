from flask import Flask, render_template

app = Flask(__name__)


@app.route("/")
def head():
    return render_template("index.html", number1=10, number2=20)

@app.route("/sum/<string:num1>/<string:num2>")
def sum(num1, num2):
    return render_template("body.html", value1=num1, value2=num2, sum=int(num1)+int(num2))


if __name__== "__main__":
    app.run(debug=True, port=8081)
