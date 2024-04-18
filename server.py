from flask import Flask,render_template,redirect,request,flash
import pymysql
import pandas as pd
app = Flask(__name__)

app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "criminals"
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

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
    dn = runstatement("CALL get_appeals();")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("appeals.html", appeals=datas)

@app.route("/charges")
def charges():
    dn = runstatement("CALL get_charges();")
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
    dn = runstatement("CALL get_criminals();")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("criminals.html", criminals=datas)

@app.route("/officers")
def officers():
    dn = runstatement("CALL get_officers();")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("officers.html", officers=datas)

@app.route("/probation_officers")
def probation_officers():
    dn = runstatement("CALL get_prob_officers();")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("probation_officers.html", prob_officers=datas)

@app.route("/sentences")
def sentences():
    dn = runstatement("CALL get_sentences();")
    datas = []
    for i,j in dn.iterrows():
        datas.append(j.to_dict())
    return render_template("sentences.html", sentences=datas)

@app.route("/sign-up", methods=['POST'])
def sign_up():
    username = request.form.get("username")
    password = request.form.get("password")
    clearance_id = request.form.get("clearance_id")
    if len(password) < 8:
        flash('Your password is too short!', 'error')
        return redirect("/")
    elif len(password) > 16:
        flash('Your password is too long!', 'error')
        return redirect("/")
    else:
        if len(username) == 0:
            flash('You didn\'t enter a username!', 'error')
            return redirect("/")
        elif len(clearance_id) == 0:
            flash('You didn\'t enter a clearance ID!', 'error')
            return redirect("/")
        else:
            password = hash(password)
            return redirect("/home")
        

if __name__ == '__main__':
    app.run(debug = True)
