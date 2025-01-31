# Import Flask modules
from flask import Flask, render_template

# Create an object named app
app = Flask(__name__) 


# Create a function named head which shows the massage as "This is my first conditions experience" in `index.html` 
# and assign to the route of ('/')
@app.route("/")
def head():
    first = "This is my first conditions experience"
    return render_template("index.html", message=first)


# Create a function named list_names which prints names in a list one by one in body.html 
# and assign to the route of ('/list')
@app.route("/list")
def list_names():
    my_names = ["Lucky", "Sal", "Amaan"]
    return render_template("body.html", object = my_names)


# run this app in debug mode on your local.
if __name__ == "__main__":
    app.run(debug=True)
