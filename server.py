from flask import Flask,render_template

app = Flask(__name__)


@app.route("/")
def home():
    return "Hello World"

@app.route("/bye")

def bye_world():
    return render_template("appeals.html")


@app.route("/name/<name>")

def hello_name(name):
    return "Hello " + name
if __name__ == '__main__':
    app.run(debug = True)
