from web3 import Web3
import json
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn import linear_model



# code to connect to ganache and get events
# 'HTTP://127.0.0.1:7545'  is the url to my ganache server

ankr_url = 'HTTP://127.0.0.1:7545'    

web3 = Web3(Web3.HTTPProvider(ankr_url))
print(web3.isConnected())
contractAddress = '0x39f927f158D0B58779138dA4cB690211749D453E'
abival=""
with open('UserCrud.json', 'r') as abi_definition:     
    abival = json.load(abi_definition) 

contract = web3.eth.contract(address=contractAddress,abi=abival["abi"])
accounts = web3.eth.accounts


my_Event = contract.events.LogNewUser() # Modification
myfilter = contract.events.LogNewUser.createFilter(fromBlock= 0,toBlock= 36)
  
eventlist = myfilter.get_all_entries()
#print(eventlist)

tranx_info = [  'args']

with open('vlaues.csv', 'w', encoding='UTF8', newline='') as f:
    writer = csv.DictWriter(f, fieldnames = tranx_info)

    # write multiple rows

    writer.writerows(eventlist[0])


#Data Cleaning for prediction

time=[]
fintime=[]
#assumed distances from usps API (as API implementation is future scope)
uspsDistance=[6800,3000,2600,3200,2200,24000,3500,5650,6100]

with open('vlaues.csv','rb') as csvfile:
    for line in csvfile.readlines():
        val=line.split(b'\t')
        int_val = str(val[7]).strip('b')
        int_val=int_val.strip("'").strip("\\r\\n")
        time.append(int_val)
for i in time[1:]:
    fintime.append(int(i))
print(fintime)
time=fintime

#Code for prediction

# before plot
plt.xlabel("Distance(miles)")
plt.ylabel("Delay(days)")
plt.scatter(uspsDistance, time)

#training linear regression model
reg = linear_model.LinearRegression()
reg.fit(df[[0]], df[1])

#predicting for distance= 3000
reg.predict([[3300]])

#after prediction plot
plt.xlabel("Distance(miles)")
plt.ylabel("Delay(days)")
plt.scatter(uspsDistance, time)
plt.plot(df[0], reg.predict(df[[0]]), color='yellow')