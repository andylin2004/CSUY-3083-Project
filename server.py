from flask import Flask,render_template,redirect,request,flash,session,url_for
import pymysql
import pandas as pd
from flask_ngrok import run_with_ngrok


app = Flask(__name__)

#run_with_ngrok(app)
app.config["MYSQL_HOST"] = "10.18.222.220"
# app.config["MYSQL_HOST"] = "localhost"
app.config["MYSQL_USER"] = "root"
app.config["MYSQL_PASSWORD"] = ""
app.config["MYSQL_DB"] = "criminals"
app.secret_key = b'_5#y2L"F4Q8z\n\xec]/'

connection = pymysql.connect(host="10.18.222.220",
                             user="root",
                             password="",
                             database="criminals")

def runstatement(statement, args=None):
    cursor = connection.cursor()
    cursor.connection.ping()
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
    try:
        thing = session["username"]

    except Exception as e:
        thing = ""
    if thing != "" or thing:
        print(thing)
        dn = runstatement("CALL check_user_grant(%s)", (thing))
        print(dn)
        if("UPDATE" in dn):
            print('hello')

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
        show_id = request.args.get("showID")
        sql_params[column] = query
        datas = []
        try:
            if column == "criminal_id":
                dn = runstatement("CALL get_appeals_by_criminal_id(%s);", (query,))
            else:
                dn = runstatement("CALL get_appeals(%s, %s, %s, %s, %s);", tuple([sql_params[column] for column in param_order]))
                if show_id is not None and show_id.isdigit():
                    specific_appeal = [x for x in datas if x['Appeal_ID'] == int(show_id)]
                    if len(specific_appeal) > 0:
                        specific_appeal = specific_appeal[0]
                        return render_template("appeals.html", appeals=datas, specific_appeal=specific_appeal)
            for _,j in dn.iterrows():
                datas.append(j.to_dict())
        except Exception as e:
            flash(str(e), 'error')

        return render_template("appeals.html", appeals=datas)
    else:
        return redirect("/")

@app.route("/charges")
def charges():
    if "username" in session:
        sql_params = {}
        param_order = ['charge_id', 'crime_id', 'crime_code', 'status', 'fine', 'court_fee', 'amt_paid', 'due_date']
        for column in param_order:
            sql_params[column] = ""
        column = request.args.get("column")
        query = request.args.get("query")
        sql_params[column] = query
        datas = []
        try:
            dn = runstatement("CALL get_charges(%s, %s, %s, %s, %s, %s, %s, %s);", tuple([sql_params[column] for column in param_order]))
            for _,j in dn.iterrows():
                datas.append(j.to_dict())
        except Exception as e:
            flash(str(e), 'error')

        return render_template("charges.html", charges=datas)
    else:
        return redirect("/")

@app.route("/crimes")
def crimes():
    if "username" in session:
        sql_params = {}
        param_order = ['crime_id', 'criminal_id', 'classification', 'date_charge', 'status', 'hearing_date', 'appeal_cutoff_date']
        for column in param_order:
            sql_params[column] = ""
        column = request.args.get("column")
        query = request.args.get("query")
        show_id = request.args.get('showID')
        sql_params[column] = query
        datas = []
        try:
            dn = runstatement("CALL get_crimes(%s,%s,%s,%s,%s,%s,%s);", tuple([sql_params[column] for column in param_order]))
            for _,j in dn.iterrows():
                datas.append(j.to_dict())
            print(datas)
            if show_id is not None and show_id.isdigit():
                specific_crime = [x for x in datas if x['Crime_ID'] == int(show_id)]
                if len(specific_crime) > 0:
                    specific_crime = specific_crime[0]
                    return render_template("crimes.html", crimes=datas, specific_crime=specific_crime)
            
        except Exception as e:
            flash(str(e), 'error')

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
        datas = []
        try:
            dn = runstatement("CALL get_criminals(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);", tuple([sql_params[column] for column in param_order]))
            for _,j in dn.iterrows():
                datas.append(j.to_dict())
        except Exception as e:
            flash(str(e), 'error')
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
        datas = []
        try:
            dn = runstatement("CALL get_officers(%s, %s, %s, %s, %s, %s, %s);", tuple([sql_params[column] for column in param_order]))
            for _,j in dn.iterrows():
                datas.append(j.to_dict())
        except Exception as e:
            flash(str(e), 'error')
            
        return render_template("officers.html", officers=datas)
    else:
        return redirect("/")

@app.route("/probation_officers")
def probation_officers():
    sql_params = {}
    param_order = ['p_id', 'l_name', 'f_name', 'street', 'city', 'state', 'zip', 'phone', 'email', 'status']
    for column in param_order:
        sql_params[column] = ""
    column = request.args.get("column")
    query = request.args.get("query")
    sql_params[column] = query
    if "username" in session:
        datas = []
        try:
            dn =runstatement("CALL get_prob_officers(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);", tuple([sql_params[column] for column in param_order]))
            for _,j in dn.iterrows():
                datas.append(j.to_dict())
        except Exception as e:
            flash(str(e), 'error')
        
        return render_template("probation_officers.html", prob_officers=datas)
    else:
        return redirect("/")

@app.route("/sentences")
def sentences():
    if "username" in session:
        sql_params = {}
        param_order = ['s_id', 'c_id', 'type', 'p_id', 'start_date', 'end_date', 'violations']
        for column in param_order:
            sql_params[column] = ""
        column = request.args.get("column")
        query = request.args.get("query")
        sql_params[column] = query
        try:
            dn = runstatement("CALL get_sentences(%s, %s, %s, %s, %s, %s, %s);", tuple([sql_params[column] for column in param_order]))
            datas = []
            for _,j in dn.iterrows():
                datas.append(j.to_dict())
            return render_template("sentences.html", sentences=datas)
        except Exception as e:
            flash(str(e), 'error')
            return redirect("/")
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
            if clearance_id == "10" or clearance_id == "3083":
                try:
                    runstatement("CALL add_user_procedure(%s, %s, %s);",(username, password, clearance_id))

                except Exception as e:
                    flash(str(e), 'error')
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
    c_id = request.form.get("c_id")
    a_id = request.form.get("a_id")
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

    try:
        runstatement("CALL add_criminal(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);", (c_id, l_name, f_name, street, city, state, zip, phone, vio_offender, probation_stat))
        if len(alias) > 0:
            try:
                runstatement("CALL add_alias_for_criminal(%s, %s, %s);", (a_id, c_id, alias))
                flash('Successfully added a new criminal!', 'success')
            except Exception as e:
                flash(str(e), 'error')
    except Exception as e:
        flash(str(e), 'error')
    

    return redirect("/criminals")

@app.route('/add-crime', methods=['POST'])
def add_crime():
    cr_id = request.form.get("cr_id")
    c_id = request.form.get("c_id")
    classification = request.form.get("classification")
    date_charged = request.form.get("date_charged")
    status = request.form.get("status")
    hearing_date = request.form.get("hearing_date")
    cutoff_date = request.form.get("cutoff_date")

    try:
        runstatement("CALL add_crime(%s, %s, %s, %s, %s, %s, %s);", (cr_id, c_id, classification, date_charged, status, hearing_date, cutoff_date))
        flash('Successfully added a new crime!', 'success')
    except Exception as e:
        flash(str(e), 'error')

    return redirect("/crimes")

@app.route('/add-probation-officer', methods=['POST'])
def add_probation_officer():
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

    try:
        runstatement("CALL add_prob_officer(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);", (prob_id, l_name, f_name, street, city, state, zip, phone, email, status))
        flash('Successfully added a new probation officer!', 'success')
    except Exception as e:
        flash(str(e), 'error')

    return redirect("/probation_officers")

@app.route('/add-officer', methods=['POST'])
def add_officer():
    officer_id = request.form.get("officer_id")
    f_name = request.form.get("f_name")
    l_name = request.form.get("l_name")
    precinct = request.form.get("precinct")
    phone = request.form.get("phone")
    badge = request.form.get("badge")
    status = request.form.get("status")

    try:
        runstatement("CALL add_officer(%s, %s, %s, %s, %s, %s, %s);", (officer_id, l_name, f_name, precinct, badge, phone, status))
        flash('Successfully added a new officer!', 'success')
    except Exception as e:
        flash(str(e), 'error')

    return redirect("/officers")

@app.route('/add-appeal', methods=['POST'])
def add_appeal():
    appeal_id = request.form.get("appeal_id")
    crime_id = request.form.get("crime_id")
    file_date = request.form.get("file_date")
    hearing_date = request.form.get("hearing_date")
    status = request.form.get("status")

    try:
        runstatement("CALL add_appeal(%s, %s, %s, %s, %s);", (appeal_id, crime_id, file_date, hearing_date, status))
        flash('Successfully added a new appeal!', 'success')
    except Exception as e:
        flash(str(e), 'error')

    return redirect("/appeals")

@app.route('/add-charge', methods=['POST'])
def add_charge():
    charge_id = request.form.get("charge_id")
    c_id = request.form.get("c_id")
    crime_code = request.form.get("crime_code")
    status = request.form.get("status")
    fine = request.form.get("fine")
    court_fee = request.form.get("court_fee")
    amount_paid = request.form.get("amount_paid")
    due_date = request.form.get("due_date")

    try:
        runstatement("CALL add_Crime_charge(%s, %s, %s, %s, %s, %s, %s, %s);", (charge_id, c_id, crime_code, status, fine, court_fee, amount_paid, due_date))
        flash('Successfully added a new charge!', 'success')
    except Exception as e:
        flash(str(e), 'error')

    return redirect("/charges")
    
@app.route('/add-sentence', methods=['POST'])
def add_sentence():
    s_id = request.form.get("s_id")
    c_id = request.form.get("c_id")
    p_id = request.form.get("p_id")
    sentence_type = request.form.get("sentence_type")
    start_date = request.form.get("start_date")
    end_date = request.form.get("end_date")
    violations = request.form.get("violations")

    try:
        runstatement("CALL add_sentence(%s, %s, %s, %s, %s, %s, %s);", (s_id, c_id, sentence_type, p_id, start_date, end_date, violations))
        flash('Successfully added a new sentence!', 'success')
    except Exception as e:
        flash(str(e), 'error')

    return redirect("/sentences")

@app.route('/delete-crimes', methods=['POST'])
def delete_crimes():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        try:
            runstatement("CALL deleteCrimes(%s);", (int(i.split("check")[1]),))
            flash('Successfully deleted a crime!', 'success')
        except Exception as e:
            flash(str(e), 'error')
        return redirect("/crimes?"+bytes.decode(request.query_string))

@app.route('/delete-criminals', methods=['POST'])
def delete_criminal():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        try:
            runstatement("CALL deleteCriminal(%s);", (int(i.split("check")[1]),))
            flash('Successfully deleted a criminal!', 'success')
        except Exception as e:
            flash(str(e), 'error')
    return redirect("/criminals")

@app.route('/delete-probation-officer', methods=['POST'])
def delete_prob_officer():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        try:
            runstatement("CALL deleteProb(%s);", (int(i.split("check")[1]),))
            flash('Successfully deleted a probation officer!', 'success')
        except Exception as e:
            flash(str(e), 'error')
    return redirect("/probation_officers")

@app.route('/delete-officer', methods=['POST'])
def delete_officer():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        try:
            runstatement("CALL deleteOfficer(%s);", (int(i.split("check")[1]),))
            flash('Successfully deleted an officer!', 'success')
        except Exception as e:
            flash(str(e), 'error')
    return redirect("/officers")

@app.route('/delete-appeals', methods=['POST'])
def delete_appeal():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        try:
            runstatement("CALL deleteAppeals(%s);", (int(i.split("check")[1]),))
            flash('Successfully deleted an appeal!', 'success')
        except Exception as e:
            flash(str(e), 'error')
    return redirect("/appeals?"+bytes.decode(request.query_string))

@app.route('/delete-charges', methods=['POST'])
def delete_charges():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        try:
            runstatement("CALL deleteCrimeCharges(%s);", (int(i.split("check")[1]),))
            flash('Successfully deleted a charge!', 'success')
        except Exception as e:
            flash(str(e), 'error')
    return redirect("/charges")

@app.route('/delete-sentences', methods=['POST'])
def delete_sentences():
    for (i,_) in request.form.items():
        print((int(i.split("check")[1]),))
        try:
            runstatement("CALL deleteSentences(%s);", (int(i.split("check")[1]),))
            flash('Successfully deleted a sentence!', 'success')
        except Exception as e:
            flash(str(e), 'error')
    return redirect("/sentences")

@app.route("/edit-criminal", methods=['POST'])
def edit_criminal():
    c_id = request.form.get("c_id")
    f_name = request.form.get("f_name")
    l_name = request.form.get("l_name")
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

    try:
        runstatement("CALL update_criminal(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);", (c_id, l_name, f_name, street, city, state, zip, phone, vio_offender, probation_stat))
        flash('Successfully deleted a criminal entry!', 'success')
    except Exception as e:
        flash(str(e), 'error')

    return redirect("/criminals")

@app.route('/edit-crime', methods=['POST'])
def edit_crime():
    cr_id = request.form.get("cr_id")
    c_id = request.form.get("c_id")
    classification = request.form.get("classification")
    date_charged = request.form.get("date_charged")
    status = request.form.get("status")
    hearing_date = request.form.get("hearing_date")
    cutoff_date = request.form.get("cutoff_date")

    try:
        runstatement("CALL update_crime(%s, %s, %s, %s, %s, %s, %s);", (cr_id, c_id, classification, date_charged, status, hearing_date, cutoff_date))
        flash('Successfully edited a crime entry!', 'success')
    except Exception as e:
        flash(str(e), 'error')
                 
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

    try:
        runstatement("CALL update_prob_officer(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s);", (prob_id, l_name, f_name, street, city, state, zip, phone, email, status))
        flash('Successfully edited a probation officer entry!', 'success')
    except Exception as e:
        flash(str(e), 'error')
                 
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

    try:
        runstatement("CALL update_officer(%s, %s, %s, %s, %s, %s, %s);", (officer_id, l_name, f_name, precinct, badge, phone, status))
        flash('Successfully edited an officer entry!', 'success')
    except Exception as e:
        flash(str(e), 'error')

    return redirect("/officers")

@app.route('/edit-appeal', methods=['POST'])
def edit_appeal():
    appeal_id = request.form.get("appeal_id")
    crime_id = request.form.get("crime_id")
    file_date = request.form.get("file_date")
    hearing_date = request.form.get("hearing_date")
    status = request.form.get("status")

    try:
        runstatement("CALL update_appeal(%s, %s, %s, %s, %s);", (appeal_id, crime_id, file_date, hearing_date, status))
        flash('Successfully edited an appeal entry!', 'success')
    except Exception as e:
        flash(str(e), 'error')

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

    try:
        runstatement("CALL update_crime_charge(%s, %s, %s, %s, %s, %s, %s, %s);", (charge_id, c_id, crime_code, status, fine, court_fee, amount_paid, due_date))
        flash('Successfully edited a charge entry!', 'success')
    except Exception as e:
        flash(str(e), 'error')

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

    try:
        runstatement("CALL update_sentence(%s, %s, %s, %s, %s, %s, %s);", (s_id, c_id, sentence_type, p_id, start_date, end_date, violations))
        flash('Successfully edited a sentence entry!', 'success')
    except Exception as e:
        flash(str(e), 'error')

    return redirect("/sentences")

if __name__ == '__main__':
    app.run(port=5002)
