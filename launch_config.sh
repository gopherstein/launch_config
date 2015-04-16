#!/bin/bash
### Change these varables to customize.

STORE_PREFIX='application_name'
ROLE='web'
LAUNCH_CONFIG_NAME="${STORE_PREFIX}${ROLE}-config01"
SUFFIX='a'
DOMAIN='example.com'
ENV='qa'
PUPPET_GROUP='Foreman build group.'
AMI='AMI-Number'
SEC_GROUP='AWS_sec group name'
BOX_SIZE='c3.2xlarge'
DISK_SIZE='80' ##GIG

#### No changes below this line ####

## The variables above get injected into the user_data. This just makes your life easy bro...
cat > ./user_data <<USERDATA
## Either put your userdata file here... Or in the ./user_data file. 
## If you put it in here you can place vars in the userdata.... 
USERDATA



### Now we make-a tha config
aws autoscaling create-launch-configuration                  \
  --launch-configuration-name $LAUNCH_CONFIG_NAME            \
  --image-id $AMI --security-groups $SEC_GROUP               \
  --user-data file://user_data --instance-type $BOX_SIZE     \
  --instance-monitoring Enabled=true                         \
  --ebs-optimized                                            \
  --block-device-mappings "[{\"DeviceName\": \"/dev/sda1\",\"Ebs\":{\"VolumeSize\":$DISK_SIZE}}]"

