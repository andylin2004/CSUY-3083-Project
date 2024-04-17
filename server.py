from flask import Flask,render_template
from flask_mysqldb import MySQL
import pandas as pd
app = Flask(__name__)

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "criminals"


mysql = MySQL(app)

def runstatement(statement):
    cursor = mysql.connection.cursor()
    cursor.execute(statement)
    results = cursor.fetchall()
    mysql.connection.commit()
    df  = ""
    if (cursor.description):
        column_names = [desc[0] for desc in cursor.description]
        df = pd.DataFrame(results, columns=column_names)
    cursor.close()





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
