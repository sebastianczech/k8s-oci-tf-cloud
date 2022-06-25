import sys
import json

input = sys.stdin.read()
input_json = json.loads(input)
print("Python external data source input : {}".format(input_json))

output = {
    "public_ip": input_json["worker_public_ip"] if "worker_public_ip" in input_json else "undefined"
}
output_json = json.dumps(output,indent=2)
print("Python external data source output : {}".format(output_json))