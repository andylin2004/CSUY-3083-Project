from flask import Flask,render_template

app = Flask(__name__)


@app.route("/")
def login():
    return render_template("index.html")


@app.route("/home")
def home():
    return render_template("home.html")

@app.route("/appeals")
def appeals():
    return render_template("appeals.html")


@app.route("/charges")
def charges():
    return render_template("charges.html")


@app.route("/crimes")
def crimes():
    return render_template("crimes.html")

@app.route("/criminals")
def criminals():
    return render_template("criminals.html")

@app.route("/officers")
def officers():
    return render_template("officers.html")


@app.route("/probation_officers")
def probation_officers():
    return render_template("probation_officers.html")

@app.route("/sentences")
def sentences():
    return render_template("sentences.html")








if __name__ == '__main__':
    app.run(debug = True)
