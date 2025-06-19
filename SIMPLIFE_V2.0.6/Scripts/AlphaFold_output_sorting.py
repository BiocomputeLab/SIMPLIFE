import json
import sys
  

file = sys.argv[1]
# Opening JSON file
f = open(file)
  
# returns JSON object as a dictionary
data = json.load(f)


with open("ptm_score_summary_filter_under70.txt", "a") as appendfile:
	if data["ptm"] <= 0.7 and data["iptm"] <= 0.7:  
		line= file + ";" + "ptm" + " " + str(data["ptm"]) + ";" + "iptm" + " " + str(data["iptm"])

		appendfile.write(line + '\n') 

	appendfile.close 
  
# Closing file
f.close()