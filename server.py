from flask import Flask,render_template,redirect,request,flash,session,url_for
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
    session.pop('username', None)
    return render_template("index.html")

@app.route("/home")
def home():
    print(session)
    if "username" in session:
        return render_template("home.html")
    else:
        return redirect("/")

@app.route("/appeals")
def appeals(): 
    if "username" in session:
        sql_params = {}
        param_order = ['a_id', 'c_id', 'file_date', 'hear_date', 'status']
        for column in param_order:
            sql_params[column] = ""
        column = request.args.get("column")
        query = request.args.get("query")
        sql_params[column] = query
        dn = runstatement("CALL get_appeals(%s, %s, %s, %s, %s);", tuple([sql_params[column] for column in param_order]))
        datas = []
        for _,j in dn.iterrows():
            datas.append(j.to_dict())
        return render_template("appeals.html", appeals=datas)
    else:
        return redirect("/")

@app.route("/charges")
def charges():
    # TODO: search query handling
    if "username" in session:
        dn = runstatement("CALL get_charges();")
        datas = []
        for _,j in dn.iterrows():
            datas.append(j.to_dict())
        return render_template("charges.html", charges=datas)

@app.route("/crimes")
def crimes():
    if "username" in session:
        sql_params = {}
        param_order = ['cr_id', 'c_id', 'classification', 'date_charge', 'status', 'hearing_date', 'appeal_cutoff_date']
        for column in param_order:
            sql_params[column] = ""
        column = request.args.get("column")
        query = request.args.get("query")
        sql_params[column] = query
        dn = runstatement("CALL get_crimes(%s,%s,%s,%s,%s,%s,%s);", tuple([sql_params[column] for column in param_order]))
        datas = []
        for _,j in dn.iterrows():
            datas.append(j.to_dict())
        return render_template("crimes.html", crimes=datas)
    else:
        return redirect("/")

@app.route("/criminals")
def criminals():
    if "username" in session:
        sql_params = {}
        param_order = ["c_id", "last", "first", "street", "city", "state", "zip", "phone", "v_status", "p_status"]
        for column in param_order:
            sql_params[column] = ""
        column = request.args.get("column")
        query = request.args.get("query")
        sql_params[column] = query
        dn = runstatement("CALL get_criminals(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);", tuple([sql_params[column] for column in param_order]))
        datas = []
        for _,j in dn.iterrows():
            datas.append(j.to_dict())
        return render_template("criminals.html", criminals=datas)
    else:
        return redirect("/")

@app.route("/officers")
def officers():
    if "username" in session:
        sql_params = {}
        param_order = ['o_id', 'l_name', 'f_name', 'precinct', 'badge', 'phone', 'status']
        for column in param_order:
            sql_params[column] = ""
        column = request.args.get("column")
        query = request.args.get("query")
        sql_params[column] = query
        dn = runstatement("CALL get_officers(%s, %s, %s, %s, %s, %s, %s);", tuple([sql_params[column] for column in param_order]))
        datas = []
        for _,j in dn.iterrows():
            datas.append(j.to_dict())
        return render_template("officers.html", officers=datas)
    else:
        return redirect("/")

@app.route("/probation_officers")
def probation_officers():
    # TODO: search query handling
    if "username" in session:
        dn = runstatement("CALL get_prob_officers();")
        datas = []
        for _,j in dn.iterrows():
            datas.append(j.to_dict())
        return render_template("probation_officers.html", prob_officers=datas)
    else:
        return redirect("/")

@app.route("/sentences")
def sentences():
    if "username" in session:
    # TODO: search query handling
        dn = runstatement("CALL get_sentences();")
        datas = []
        for _,j in dn.iterrows():
            datas.append(j.to_dict())
        return render_template("sentences.html", sentences=datas)
    else:
        return redirect("/")

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
            if clearance_id == "10":
                dn = runstatement("CALL add_user(%s, %s);",(username, password))
            return redirect("/")

@app.route("/login", methods=['POST'])
def login():
    username = request.form.get("username")
    password = request.form.get("password")
    result = 0

    cursor =  connection.cursor()
   # Call the stored procedure
    cursor.callproc('check_user', (username, password))

    result = cursor.fetchone()[0]
    print(result)

    if (result) == 0:
        flash('Not valid user', 'error')
        return redirect("/")
           
    # dn = runstatement("CALL check_user(%s, %s, @result);",(username, password, ))
    # print(dn)
    # print(username, password)
    # if not result: 
    #     flash('Not valid user', 'error')
    #     return redirect("/")

    # TODO: add user account authentication
    session["username"] = username

    return redirect(url_for("home"))





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

    new_id = 78
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

@app.route('/delete-crimes', methods=['POST'])
def delete_crimes():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        runstatement("CALL deleteCrimes(%s);", (int(i.split("check")[1]),))
    return redirect("/crimes")

@app.route('/delete-criminals', methods=['POST'])
def delete_criminal():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        runstatement("CALL deleteCriminal(%s);", (int(i.split("check")[1]),))
    return redirect("/criminals")

@app.route('/delete-probation-officer', methods=['POST'])
def delete_prob_officer():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        runstatement("CALL deleteProb(%s);", (int(i.split("check")[1]),))
    return redirect("/probation_officers")

@app.route('/delete-officer', methods=['POST'])
def delete_officer():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        runstatement("CALL deleteOfficer(%s);", (int(i.split("check")[1]),))
    return redirect("/officers")

@app.route('/delete-appeals', methods=['POST'])
def delete_appeal():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        runstatement("CALL deleteAppeals(%s);", (int(i.split("check")[1]),))
    return redirect("/appeals")

@app.route('/delete-charges', methods=['POST'])
def delete_charges():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        runstatement("CALL deleteCrimeCharges(%s);", (int(i.split("check")[1]),))
    return redirect("/charges")

@app.route('/delete-sentences', methods=['POST'])
def delete_sentences():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        runstatement("CALL deleteSentences(%s);", (int(i.split("check")[1]),))
    return redirect("/sentences")

@app.route('/edit-crime', methods=['POST'])
def edit_crime():
    cr_id = request.form.get("cr_id")
    c_id = request.form.get("c_id")
    classification = request.form.get("classification")
    date_charged = request.form.get("date_charged")
    status = request.form.get("status")
    hearing_date = request.form.get("hearing_date")
    cutoff_date = request.form.get("cutoff_date")

    runstatement("CALL update_crime(%s, %s, %s, %s, %s, %s, %s);", (cr_id, c_id, classification, date_charged, status, hearing_date, cutoff_date))
                 
    return redirect("/crimes")

@app.route('/edit-probation-officer', methods=['POST'])
def edit_prob_officer():
    prob_id = request.form.get("prob_id")
    f_name = request.form.get("f_name")
    l_name = request.form.get("l_name")
    street = request.form.get("street")
    city = request.form.get("city")
    state = request.form.get("state")
    zip = request.form.get("zip")
    phone = request.form.get("phone")
    email = request.form.get("email")
    status = request.form.get("status")

    runstatement("CALL update_prob_officer(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);", (prob_id, l_name, f_name, street, city, state, zip, phone, email, status))
                 
    return redirect("/probation_officers")

@app.route('/edit-officer', methods=['POST'])
def edit_officer():
    officer_id = request.form.get("officer_id")
    f_name = request.form.get("f_name")
    l_name = request.form.get("l_name")
    precinct = request.form.get("precinct")
    phone = request.form.get("phone")
    badge = request.form.get("badge")
    status = request.form.get("status")

    print(officer_id)

    runstatement("CALL update_officer(%s, %s, %s, %s, %s, %s, %s);", (officer_id, l_name, f_name, precinct, badge, phone, status))

    return redirect("/officers")

@app.route('/edit-appeal', methods=['POST'])
def edit_appeal():
    appeal_id = request.form.get("appeal_id")
    crime_id = request.form.get("crime_id")
    file_date = request.form.get("file_date")
    hearing_date = request.form.get("hearing_date")
    status = request.form.get("status")

    runstatement("CALL update_appeal(%s, %s, %s, %s, %s);", (appeal_id, crime_id, file_date, hearing_date, status))

    return redirect("/appeals")

@app.route('/edit-charge', methods=['POST'])
def edit_charge():
    charge_id = request.form.get("charge_id")
    c_id = request.form.get("c_id")
    crime_code = request.form.get("crime_code")
    status = request.form.get("status")
    fine = request.form.get("fine")
    court_fee = request.form.get("court_fee")
    amount_paid = request.form.get("amount_paid")
    due_date = request.form.get("due_date")

    runstatement("CALL update_crime_charge(%s, %s, %s, %s, %s, %s, %s, %s);", (charge_id, c_id, crime_code, status, fine, court_fee, amount_paid, due_date))

    return redirect("/charges")

@app.route('/edit-sentence', methods=['POST'])
def edit_sentence():
    s_id = request.form.get("s_id")
    c_id = request.form.get("c_id")
    p_id = request.form.get("p_id")
    sentence_type = request.form.get("sentence_type")
    start_date = request.form.get("start_date")
    end_date = request.form.get("end_date")
    violations = request.form.get("violations")

    runstatement("CALL update_sentence(%s, %s, %s, %s, %s, %s, %s);", (s_id, c_id, sentence_type, p_id, start_date, end_date, violations))

    return redirect("/sentences")

if __name__ == '__main__':
    app.run(debug = True)
