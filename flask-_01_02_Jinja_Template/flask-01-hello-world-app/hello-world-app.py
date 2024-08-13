from flask import Flask 
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/second")
def second():
    return "This is the second page"

@app.route("/third/subthird")
def third():
    return "This is the subpage of the third page"

@app.route("/whichpage/<string:page_id>")
def whichpage(page_id):
    if page_id.isdigit():
        message = f"The id of this page is {page_id}"
    else:
        message = f"{page_id} is not a valid id"

    return message



if __name__ == '__main__':

    app.run(debug=True, port=8081)
