import sys
import json

# input = sys.stdin.read()
# input_json = json.loads(input)
# print("Python external data source input : {}".format(input_json))

# output = {
#     "public_ip": input_json["worker_public_ip"] if "worker_public_ip" in input_json else "undefined"
# }
# output_json = json.dumps(output,indent=2)
# print("Python external data source output : {}".format(output_json))

# Magical list of ip addresses and ports which cannot exist in terraform
test_var = dict()
test_var["dev"]   = "10.0.0.1:8081"
test_var["qa"]    = "10.0.0.2:8082"
test_var["uat"]   = "10.0.0.3:8083"
test_var["stage"] = "10.0.0.4:8084"
test_var["prod"]  = "10.0.0.5:8085"

# Step#1 - Parse the input
input = sys.stdin.read()
input_json = json.loads(input)

# Step#2 - Extract the ip address and port number based on the key passed
arr = test_var[input_json.get("p_env")].split(":")
ip_address = arr[0]
port_num = arr[1]


# Step#3 -  Create a JSON object and just print it(i.e send it to stdout)
output = {
    "ip_address": ip_address,
    "port_num": port_num
}

output_json = json.dumps(output,indent=2)
print(output_json)