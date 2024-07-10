#!/usr/bin/env python

import boto3
import json

def get_ec2_instances():
    ec2 = boto3.resource('ec2')
    instances = ec2.instances.filter(
        Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
    
    inventory = {'all': {'hosts': []}}

    for instance in instances:
        if instance.public_dns_name:
            inventory['all']['hosts'].append(instance.public_dns_name)
    
    return inventory

if __name__ == "__main__":
    inventory = get_ec2_instances()
    print(json.dumps(inventory, indent=2))
