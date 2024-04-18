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

def runstatement(statement, args=None):
    cursor = connection.cursor()
    cursor.execute(statement, args)
    results = cursor.fetchall()
    connection.commit()
    df  = ""
    if (cursor.description):
        column_names = [desc[0] for desc in cursor.description]
        df = pd.DataFrame(results, columns=column_names)
    cursor.close()
    return df

@app.route("/")
def go_to_index():
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

@app.route("/login", methods=['POST'])
def login():
    username = request.form.get("username")
    password = request.form.get("password")
    # TODO: add user account authentication
    return redirect("/home")

@app.route("/add-criminal", methods=['POST'])
def add_criminal():
    f_name = request.form.get("f_name")
    l_name = request.form.get("l_name")
    alias = request.form.get("alias")
    street = request.form.get("street")
    city = request.form.get("city")
    state = request.form.get("state")
    zip = request.form.get("zip")
    phone = request.form.get("phone")
    vio_offender = request.form.get("vio_offender")
    probation_stat = request.form.get("probation_stat")

    if vio_offender != None:
        vio_offender = 'Y'
    else:
        vio_offender = 'N'

    if probation_stat != None:
        probation_stat = 'Y'
    else:
        probation_stat = 'N'

    # TODO: make the new id match the count of rows of the table; same thing for the alias id

    new_id = 77
    runstatement("CALL add_criminal(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);", (new_id, l_name, f_name, street, city, state, zip, phone, vio_offender, probation_stat))
    new_alias_id = 77
    if len(alias) > 0:
        runstatement("CALL add_alias_for_criminal(%s, %s, %s);", (new_alias_id, new_id, alias))

    return redirect("/criminals")

@app.route('/add-crime', methods=['POST'])
def add_crime():
    c_id = request.form.get("c_id")
    classification = request.form.get("classification")
    date_charged = request.form.get("date_charged")
    status = request.form.get("status")
    hearing_date = request.form.get("hearing_date")
    cutoff_date = request.form.get("cutoff_date")

    # TODO: make the new id the same as the count of crimes
    new_id = 78
    runstatement("CALL add_crime(%s, %s, %s, %s, %s, %s, %s);", (new_id, c_id, classification, date_charged, status, hearing_date, cutoff_date))

    return redirect("/crimes")

@app.route('/add-probation-officer', methods=['POST'])
def add_probation_officer():
    f_name = request.form.get("f_name")
    l_name = request.form.get("l_name")
    street = request.form.get("street")
    city = request.form.get("city")
    state = request.form.get("state")
    zip = request.form.get("zip")
    phone = request.form.get("phone")
    email = request.form.get("email")
    status = request.form.get("status")

    # TODO: make the new id the same as the count of probation officers
    new_id = 78

    runstatement("CALL add_prob_officer(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);", (new_id, l_name, f_name, street, city, state, zip, phone, email, status))

    return redirect("/probation_officers")

@app.route('/add-officer', methods=['POST'])
def add_officer():
    f_name = request.form.get("f_name")
    l_name = request.form.get("l_name")
    precinct = request.form.get("precinct")
    phone = request.form.get("phone")
    badge = request.form.get("badge")
    status = request.form.get("status")

    # TODO: make the new id the same as the count of officers
    new_id = 78

    runstatement("CALL add_officer(%s, %s, %s, %s, %s, %s, %s);", (new_id, l_name, f_name, precinct, badge, phone, status))

    return redirect("/officers")

@app.route('/add-appeal', methods=['POST'])
def add_appeal():
    crime_id = request.form.get("crime_id")
    file_date = request.form.get("file_date")
    hearing_date = request.form.get("hearing_date")
    status = request.form.get("status")
    
    # TODO: make the new id the same as the count of appeals
    new_id = 78

    runstatement("CALL add_appeal(%s, %s, %s, %s, %s);", (new_id, crime_id, file_date, hearing_date, status))

    return redirect("/appeals")

@app.route('/add-charge', methods=['POST'])
def add_charge():
    c_id = request.form.get("c_id")
    crime_code = request.form.get("crime_code")
    status = request.form.get("status")
    fine = request.form.get("fine")
    court_fee = request.form.get("court_fee")
    amount_paid = request.form.get("amount_paid")
    due_date = request.form.get("due_date")

    # TODO: make the new id the same as the count of charges
    new_id = 78

    runstatement("CALL add_Crime_charge(%s, %s, %s, %s, %s, %s, %s, %s);", (new_id, c_id, crime_code, status, fine, court_fee, amount_paid, due_date))

    return redirect("/charges")
    
@app.route('/add-sentence', methods=['POST'])
def add_sentence():
    # ('c_id', ''), ('sentence_type', ''), ('start_date', ''), ('end_date', ''), ('violations', '')

    c_id = request.form.get("c_id")
    p_id = request.form.get("p_id")
    sentence_type = request.form.get("sentence_type")
    start_date = request.form.get("start_date")
    end_date = request.form.get("end_date")
    violations = request.form.get("violations")

    # TODO: make the new id the same as the count of sentences
    new_id = 78

    runstatement("CALL add_sentence(%s, %s, %s, %s, %s, %s, %s);", (new_id, c_id, sentence_type, p_id, start_date, end_date, violations))

    return redirect("/sentences")

if __name__ == '__main__':
    app.run(debug = True)
