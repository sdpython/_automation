# -*- coding: utf-8 -*-
"""
Download data from mail and evaluate performance
================================================

"""

#########################################
# import

import os
import io
import sys
import pandas
from zipfile import ZipFile
try:
    from pyquickhelper.loghelper import fLOG
except ImportError:
    sys.path.append("../../pyquickhelper/src")
    sys.path.append("../../pyensae/src")
    sys.path.append("../../jyquickhelper/src")
    sys.path.append("../../pymmails/src")
    sys.path.append("../../lightmlboard/src")
    from pyquickhelper.loghelper import fLOG

#############################
# Credentials
import keyring
user = keyring.get_password("gmail", os.environ["COMPUTERNAME"] + "user")
pwd = keyring.get_password("gmail", os.environ["COMPUTERNAME"] + "pwd")

###############################
# Read oracles.

full = pandas.read_csv("full_db_days_ch1.csv", sep=";")
full = full.fillna(180)
cls = full.columns[0]

to_test = dict(
    oracle1=r'C:\xavierdupre\__home_\github_clone\Hackathon2k17\final_data\oracle.ch1_1.csv',
    oracle1_2=r'C:\xavierdupre\__home_\github_clone\Hackathon2k17\final_data\oracle.ch1_2.csv',
    oracle1_100=r'100produits.csv',
    oracle2=r'C:\xavierdupre\__home_\github_clone\Hackathon2k17\final_data\oracle.ch2.csv',
    oracle2_2="baseline_ch2.csv",
)

to_string = {}
for k, v in to_test.items():
    with open(v, "r") as f:
        to_string[k] = f.read()


def compute_metrics(datas):
    rec = {}
    for k, v in to_string.items():
        val = io.StringIO(datas)
        exp = io.StringIO(v)
        try:
            multi_label_jaccard(exp, val, exc=False)
        except (pandas.errors.ParserError, pandas.errors.EmptyDataError) as e:
            rec["error"] = str(e)
            continue

        val = io.StringIO(datas)
        exp = io.StringIO(v)
        if 1:  # try:
            met1 = multi_label_jaccard(exp, val, exc=False)
        else:  # except Exception as e:
            met1 = str(e)
        val = io.StringIO(datas)
        exp = io.StringIO(v)
        if 1:  # try:
            met2 = l1_reg_max(exp, val, exc=False)
        else:  # except Exception as e:
            met2 = str(e)
        val = io.StringIO(datas)
        exp = io.StringIO(v)
        if 1:  # try:
            met3 = l1_reg_max(exp, val, nomax=True, exc=False)
        else:  # except Exception as e:
            met3 = str(e)
        rec[k + "_reg"] = met2
        rec[k + "_jac"] = met1
        rec[k + "_reg_no180"] = met3

    if False:
        for k, v in common_set.items():
            df = pandas.read_csv(io.StringIO(datas), sep=";", header=None)
            co = df.columns[0]
            prod = df[co]
            inter = len(set(prod) & v)
            rec[k + "_common"] = inter

    return rec


#############################################
# Measure performances.
from pymmails import MailBoxImap, EmailMessageRenderer
from lightmlboard.metrics.regression_custom import l1_reg_max
from lightmlboard.metrics.classification import multi_label_jaccard
fLOG(OutputPrint=True)

perf_both = []

rev = []
for k, v in to_string.items():
    rec = compute_metrics(v)
    rec['a_sender'] = k
    perf_both.append(rec)

for name in os.listdir("sub"):
    with open(os.path.join("sub", name), "rb") as f:
        c = f.read()
    mail = dict(From=name,
                Date=os.stat(os.path.join('sub', name)).st_mtime,
                name=name,
                att=c)
    rev.append((mail['Date'], mail))

if False:
    server = "imap.gmail.com"
    box = MailBoxImap(user, pwd, server, ssl=True)
    box.login()
    for i, mail in enumerate(box.enumerate_mails_in_folder(
            "ensae/hackathon", date="24-Nov-2017")):
        if 'dupre' in mail['From']:
            continue
        rev.append((mail["Date"], mail))
        fLOG(i, mail["Date"], mail['From'])
else:
    box = None


fLOG('----------------------')
for date, mail in rev:
    fLOG(mail["Date"], mail['From'])
    if 'att' in mail:
        att = (mail['name'], mail['att'])
    else:
        for att_ in mail.enumerate_attachments():
            att = att_
            break
    if ".zip" in att[0]:
        content = att[1]
        st = io.BytesIO(content)
        with ZipFile(st) as myzip:
            infos = myzip.infolist()
            if len(infos) != 1:
                fLOG("skip mail '{0}' from '{1}'".format(i, mail['From']))
            else:
                name = infos[0].filename
                data = myzip.read(name)
                datas = data.decode('ascii')
                rec = compute_metrics(datas)
                rec["a_sender"] = mail['From']
                perf_both.append(rec)
                rec['a_date'] = mail['Date']
    elif ".csv" in att[0]:
        datas = att[1].decode('ascii', errors='ignore')
        try:
            df = pandas.read_csv(io.StringIO(datas), sep=";")
            if df.shape[1] == 1:
                raise Exception("one column only")
        except Exception as e:
            fLOG("Replace , by .")
            datas = datas.replace(".", ";").replace(
                ",", ".").replace('\t', ';')
        if datas.startswith("product"):
            datas = '\n'.join(datas.split('\n')[1:])
        if 1:  # try:
            rec = compute_metrics(datas)
        else:  # except Exception as e:
            rec = {}
            rec['error'] = str(e)
        rec["a_sender"] = mail['From']
        rec['a_date'] = mail['Date']
        perf_both.append(rec)
    else:
        fLOG("No zip file in mail {0}".format(i))

if box:
    box.logout()

#######################################
# Saves
df = pandas.DataFrame(perf_both)
df = df[list(sorted(df.columns))]
filename = "perfhack.xlsx"
df.to_excel(filename, index=False)
print(df.shape, df.head().T)

##########################
# Send.
mails = ";".join(list(sorted(df['a_sender'].dropna())))

if False:
    from pymmails import create_smtp_server, send_email
    server = create_smtp_server("gmail", user, pwd)
    send_email(server, "xavier.dupre@gmail.com",
               mails, "Hackathon-Leaderboard",
               body_html=df.to_html(),
               attachements=["perfhack.xlsx"])
    server.quit()
