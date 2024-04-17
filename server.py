from flask import Flask,render_template
import pymysql
import pandas as pd
app = Flask(__name__)

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "criminals"

connection = pymysql.connect(host="localhost",
                             user="root",
                             password="",
                             database="criminals")

def runstatement(statement):
    cursor = connection.cursor()
    cursor.execute(statement)
    results = cursor.fetchall()
    connection.commit()
    df  = ""
    if (cursor.description):
        column_names = [desc[0] for desc in cursor.description]
        df = pd.DataFrame(results, columns=column_names)
    cursor.close()
    return df





@app.route("/")
def login():
    return render_template("index.html")


@app.route("/home")
def home():
    return render_template("home.html")

@app.route("/appeals")
def appeals():
    dn = runstatement("SELECT * FROM appeals;")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("appeals.html", appeals=datas)



@app.route("/charges")
def charges():
    dn = runstatement("SELECT * FROM crime_charges;")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("charges.html", charges=datas)


@app.route("/crimes")
def crimes():
    dn = runstatement("CALL get_crimes();")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("crimes.html", crimes=datas)

@app.route("/criminals")
def criminals():
    dn = runstatement("SELECT * FROM criminals;")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("criminals.html", criminals=datas)

@app.route("/officers")
def officers():
    dn = runstatement("SELECT * FROM officers;")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("officers.html", officers=datas)


@app.route("/probation_officers")
def probation_officers():
    dn = runstatement("SELECT * FROM prob_officers;")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("probation_officers.html", probation_officers=datas)


@app.route("/sentences")
def sentences():
    dn = runstatement("SELECT * FROM sentences;")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("sentences.html", sentences=datas)








if __name__ == '__main__':
    app.run(debug = True)
